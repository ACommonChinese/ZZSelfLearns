动态绑定
=================

在oc中，我们知道，不可以为类扩展添加属性，但是我们可以添加动态关联对象。这需要运行时的API.
有这种需求吗？ 举个例子，假设一个界面上有很多button,  每个button代表一名学生，每当我们点击一个button时，进入另外一个视图控制器，但相应的把学生信息传给controller, 这种情况下我们一般有两种做法：  

第一种：给button设置tag值，再把学生信息放入数组中，当点击button时，根据button的tag值取相应的数组中的学生对象  
第二种：继承于UIButton, 用我们自己的button，比如StudentButton，在继承类中有个student属性，然后创建button的时候让button.student = aStudent   

按照面向对象的思维来讲，使用第二种是比较好的解决方法，让button本身具有'学生'这个model, 但如果在项目中我们已大量的使用了UIButton, 怎么办？这时候我们就可以考虑使用类扩展，在扩展中让UIButton具有student属性，但扩展是不能添加成员变量的，这个时候，我们就需要使用动态绑定。

**参见代码：Demo_1**

```
#import "UIButton+Student.h"
#import <objc/runtime.h>
@implementation UIButton (Student)

- (void)setStudent:(Student *)student {
    objc_setAssociatedObject(self, "student_key", student, OBJC_ASSOCIATION_RETAIN);
}
- (Student *)student {
    return objc_getAssociatedObject(self, "student_key");
}

@end
```

```
#import "ViewController.h"
#import "UIButton+Student.h"

@interface ViewController ()
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    Student *student = [[Student alloc] init];
    student.id = @"080902053";
    student.name = @"刘威振";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoDark];
    button.center = self.view.center;
    button.student = student;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClick:(UIButton *)button {
    Student *student = button.student;
    NSLog(@"id: %@ -- name: %@", student.id, student.name); // id: 080902053 -- name: 刘威振
}

@end
```

在上面对UIButton的扩展中使用的中的key是"student_key"，使用这种固定字符串作为key，容易拼写错误，我们可以改写为：

```
- (void)setStudent:(Student *)student {
    objc_setAssociatedObject(self, @selector(student), student, OBJC_ASSOCIATION_RETAIN);
}

- (Student *)student {
    return objc_getAssociatedObject(self, _cmd);
}
```

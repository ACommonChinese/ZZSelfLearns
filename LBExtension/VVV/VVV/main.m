//
//  main.m
//  VVV
//
//  Created by liuweizhen on 2017/5/9.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *s = @"@\"Book\"";
        NSLog(@"<<%@>>", [s substringWithRange:NSMakeRange(2, s.length-3)]);
        
        Student *student = [[Student alloc] init];
        student.name = [NSMutableString stringWithFormat:@"%@", @"fdsfsdf"];
        // [student setValue:@"IHING" forKey:@"name"];
        [student.name appendString:@" ><><>"];
        NSLog(@"%@", student.name);
    }
    return 0;
}

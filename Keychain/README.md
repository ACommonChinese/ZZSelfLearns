# keychain

iOS的keychain服务提供了一种安全的保存私密信息（密码，序列号，证书等）的方式。每个ios程序都有一个独立的keychain存储。
苹果已经有现成的类封装好了keychain: KeychainItemWrapper.h和KeychainItemWrapper.m文件,可以在GenericKeychain实例里找到: [https://developer.apple.com/library/content/samplecode/GenericKeychain/Introduction/Intro.html](https://developer.apple.com/library/content/samplecode/GenericKeychain/Introduction/Intro.html)

Apple keychain相关：
[https://developer.apple.com/library/content/documentation/Security/Conceptual/keychainServConcepts/01introduction/introduction.html](https://developer.apple.com/library/content/documentation/Security/Conceptual/keychainServConcepts/01introduction/introduction.html)

需要注意： 
1. KeyChainItemWrapper类没有使用ARC的方式开发(至少早期的demo不是使用ARC的), 因此要为.m文件加上-fno-objc-arc编译器标记。
2. 添加Security.framework


  ​
参考链接：[https://www.lvtao.net/ios/ios-keychain.html](https://www.lvtao.net/ios/ios-keychain.html)
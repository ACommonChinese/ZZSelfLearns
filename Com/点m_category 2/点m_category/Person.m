//
//  Person.m
//  点m_category
//
//  Created by liuweizhen on 2019/1/16.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import "Person.h"
#import "Person+Physical.h"
#import "Person+Mental.h"
// #import "Person+Private.h"

@implementation Person

- (void)start {
    [self physical];
    [self mental];
}

- (void)physical {
    [self detailPhysical];
}

- (void)mental {
    [self detailMental];
}

- (void)drink {
    NSLog(@"喝点水歇歇...");
}

@end

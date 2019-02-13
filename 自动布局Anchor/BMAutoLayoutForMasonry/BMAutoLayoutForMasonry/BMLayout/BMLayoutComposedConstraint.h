//
//  BMLayoutComposedConstraint.h
//  BMAutoLayoutForMasonry
//
//  Created by liuweizhen on 2019/2/1.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import "BMLayoutConstraint.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMLayoutComposedConstraint : BMLayoutConstraint

@property (nonatomic, strong) NSMutableArray *children;

@end

NS_ASSUME_NONNULL_END

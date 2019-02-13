//
//  BMLayoutProtocol.h
//  BMAutoLayoutForMasonry
//
//  Created by liuweizhen on 2019/2/1.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BMLayout;

NS_ASSUME_NONNULL_BEGIN

@protocol BMLayoutProtocol <NSObject>

- (UIView *)attachView;
- (NSLayoutAnchor *)getAnchor:(NSLayoutAttribute)attribute;
- (NSLayoutAnchor *)getAnchor:(NSLayoutAttribute)attribute ofView:(UIView *)view;
- (NSLayoutAnchor *)getAnchor:(NSLayoutAttribute)attribute ofGuide:(UILayoutGuide *)guide;
- (BMLayout *)layout;

@end

NS_ASSUME_NONNULL_END

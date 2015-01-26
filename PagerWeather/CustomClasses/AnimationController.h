//
//  AnimationController.h
//  PagerWeather
//
//  Created by ricardo hernandez on 1/21/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AnimationControllerAnimationType) {
    AnimationControllerAnimationTypeSimple,
    AnimationControllerAnimationTypePresent,
    AnimationControllerAnimationTypeDismiss
};

@interface AnimationController : NSObject <UIViewControllerAnimatedTransitioning>

- (id)initWithAnimationType:(AnimationControllerAnimationType)animationType;
@property (nonatomic, assign) UIViewAnimationOptions options;

@end

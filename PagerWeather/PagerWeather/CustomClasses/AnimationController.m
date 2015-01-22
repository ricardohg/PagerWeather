//
//  AnimationController.m
//  PagerWeather
//
//  Created by ricardo hernandez on 1/21/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import "AnimationController.h"

@implementation AnimationController

- (instancetype)init
{
    return [self initWithDuration:0.5 options:UIViewAnimationOptionTransitionNone];
}


- (instancetype)initWithDuration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options
{
    self = [super init];
    if (self) {
        self.duration = duration;
        self.options = options;
    }
    
    return self;
}


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    [toViewController.view layoutIfNeeded];
    
    [UIView transitionFromView:fromViewController.view
                        toView:toViewController.view
                      duration:self.duration
                       options:self.options
                    completion:^(BOOL finished) {
                        [transitionContext completeTransition:YES];
                    }];
}


@end

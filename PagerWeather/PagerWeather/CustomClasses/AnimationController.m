//
//  AnimationController.m
//  PagerWeather
//
//  Created by ricardo hernandez on 1/21/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import "AnimationController.h"

@interface AnimationController ()

@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) AnimationControllerAnimationType animationType;

@end

@implementation AnimationController

- (instancetype)init
{
    return [self initWithAnimationType:AnimationControllerAnimationTypeSimple];
}

- (id)initWithAnimationType:(AnimationControllerAnimationType)animationType
{
    self = [super init];
    if (self) {
        switch (animationType) {
            case AnimationControllerAnimationTypeSimple: {
                self.duration = 0.5;
                self.options = UIViewAnimationOptionTransitionNone;
                self.animationType = animationType;
            }
                break;
            case AnimationControllerAnimationTypePresent: {
                self.duration = 0.5;
                self.animationType = animationType;
            }
                break;
            case AnimationControllerAnimationTypeDismiss: {
                self.duration = 0.2;
                self.animationType = animationType;
            }
                break;
            default:
                break;
        }
    }
    
    return self;
    
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (self.animationType) {
        case AnimationControllerAnimationTypeSimple: {
            [self animateTransitionSimple:transitionContext];
        }
            break;
        case AnimationControllerAnimationTypePresent: {
            [self animateTransitionForPresent:transitionContext];
        }
            break;
        case AnimationControllerAnimationTypeDismiss: {
            [self animateTransitionForDismiss:transitionContext];
        }
            break;
        default:
            break;
    }
}


- (void)animateTransitionSimple:(id<UIViewControllerContextTransitioning>)transitionContext
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

- (void)animateTransitionForDismiss:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:3.0 * duration / 4.0
                          delay:duration / 4.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         fromViewController.view.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         [fromViewController.view removeFromSuperview];
                         [transitionContext completeTransition:YES];
                     }];
    
    [UIView animateWithDuration:2.0 * duration
                          delay:0.0
         usingSpringWithDamping:1.0
          initialSpringVelocity:-15.0
                        options:0
                     animations:^{
                         fromViewController.view.transform = CGAffineTransformMakeScale(0.3, 0.3);
                     }
                     completion:nil];
}

- (void)animateTransitionForPresent:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    CGRect frame = containerView.bounds;
    
    toViewController.view.frame = frame;
    
    [containerView addSubview:toViewController.view];
    
    toViewController.view.alpha = 0.0;
    toViewController.view.transform = CGAffineTransformMakeScale(0.3, 0.3);
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration / 2.0 animations:^{
        toViewController.view.alpha = 1.0;
    }];
    
    CGFloat damping = 0.55;
    
    [UIView animateWithDuration:duration delay:0.0 usingSpringWithDamping:damping initialSpringVelocity:1.0 / damping options:0 animations:^{
        toViewController.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end

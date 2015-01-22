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
                self.animationType = animationType;
            }
                break;
            case AnimationControllerAnimationTypeDismiss: {
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
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    CGPoint centerOffScreen = containerView.center;
    centerOffScreen.y = containerView.frame.size.height*2;
    [UIView animateWithDuration:1.0 delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        fromViewController.view.center = centerOffScreen;
        
    } completion:^(BOOL finished) {
        
        
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        toViewController.view.alpha = 1.0;
        toViewController.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
    
}

- (void)animateTransitionForPresent:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    CGRect frame = containerView.bounds;
    
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    [toViewController.view layoutIfNeeded];
    fromViewController.view.frame = frame;
    
    [containerView addSubview:toViewController.view];
    
    fromViewController.view.alpha = 1.0;
    
    
    [UIView animateWithDuration:0.2 animations:^{
        fromViewController.view.alpha = 0.7;
        fromViewController.view.transform = CGAffineTransformMakeScale(0.9, 0.9);
    }];
    
    CGPoint centerOffScreen = containerView.center;
    
    centerOffScreen.y = containerView.frame.size.height;
    toViewController.view.center = centerOffScreen;
    
    [UIView animateWithDuration:1.0 delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:2.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        toViewController.view.center = containerView.center;
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:YES];
    }];
}

@end

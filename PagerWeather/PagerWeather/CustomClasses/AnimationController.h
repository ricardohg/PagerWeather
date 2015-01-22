//
//  AnimationController.h
//  PagerWeather
//
//  Created by ricardo hernandez on 1/21/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationController : NSObject <UIViewControllerAnimatedTransitioning>

- (id)initWithDuration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options;

@property (nonatomic,assign) NSTimeInterval duration;
@property (nonatomic,assign) UIViewAnimationOptions options;

@end

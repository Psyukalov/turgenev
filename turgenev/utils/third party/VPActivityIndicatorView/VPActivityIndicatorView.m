//
//  VPActivityIndicatorView.m
//
//
//  Created by Vladimir Psyukalov on 26.06.17.
//  Copyright © 2017 YOUROCK INC. All rights reserved.
//


#import "VPActivityIndicatorView.h"

#import "Macros.h"


#define KAnimationKey (@"activity_indicator_view_rotate_animation")

#define kFadeInOutDuration (.32f)


@interface VPActivityIndicatorView ()

@property (strong, nonatomic) CABasicAnimation *animation;

@property (assign, nonatomic) BOOL isAnimating;

@end


@implementation VPActivityIndicatorView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    if (!self.image) {
        self.image = [UIImage imageNamed:@"activity_indicator_i.png"];
    }
    [self sizeToFit];
    self.transform = CGAffineTransformMakeScale(.64f, .64f);
    self.alpha = 0.f;
    self.layer.zPosition = 128.f;
    _animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    _animation.fromValue = @0.f;
    _animation.toValue = @(2 * M_PI);
    _animation.duration = 1.f;
    _animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    _animation.repeatCount = INFINITY;
}

- (void)play {
    [self playWithComlpetion:nil];
}

- (void)playWithComlpetion:(void (^)(void))completion {
    if (_isAnimating) {
        if (completion) {
            completion();
        }
        return;
    }
    _isAnimating = YES;
    [self.layer removeAnimationForKey:KAnimationKey];
    [self.layer addAnimation:_animation
                      forKey:KAnimationKey];
    [UIView animateWithDuration:kFadeInOutDuration
                          delay:0.f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.transform = CGAffineTransformIdentity;
                         self.alpha = 1.f;
                     }
                     completion:^(BOOL finished) {
                         if (completion) {
                             completion();
                         }
                     }];
}

- (void)stop {
    [self stopWithComlpetion:nil];
}

- (void)stopWithComlpetion:(void (^)(void))completion {
    if (!_isAnimating) {
        if (completion) {
            completion();
        }
        return;
    }
    [UIView animateWithDuration:kFadeInOutDuration
                          delay:0.f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.transform = CGAffineTransformMakeScale(.64f, .64f);
                         self.alpha = 0.f;
                     }
                     completion:^(BOOL finished) {
                         _isAnimating = NO;
                         [self.layer removeAnimationForKey:KAnimationKey];
                         if (completion) {
                             completion();
                         }
                     }];
}

@end

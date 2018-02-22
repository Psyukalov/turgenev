//
//  TCollectionView.m
//  turgenev
//
//  Created by Vladimir Psyukalov on 22.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "TCollectionView.h"

#import "UIView+Custom.h"


@implementation TCollectionView

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)(void))completion {
    CGAffineTransform transform = hidden ? CGAffineTransformMakeTranslation(0.f, self.frame.size.height) : CGAffineTransformIdentity;
    if (animated) {
        [UIView animate:^{
            self.transform = transform;
        }
             completion:^{
                 if (completion) {
                     completion ();
                 }
             }];
    } else {
        self.transform = transform;
        if (completion) {
            completion ();
        }
    }
}

@end

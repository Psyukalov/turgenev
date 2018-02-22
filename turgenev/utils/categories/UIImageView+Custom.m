//
//  UIImageView+Custom.m
//
//
//  Created by Vladimir Psyukalov on 13.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "UIImageView+Custom.h"


@implementation UIImageView (Custom)

- (void)contentModeWithFill:(BOOL)fill {
    UIViewContentMode contentMode = UIViewContentModeScaleToFill;
    CGFloat width = self.image.size.width;
    CGFloat height = self.image.size.height;
    CGFloat value = width / height;
    if (value < 1.f) {
        contentMode = fill ? UIViewContentModeScaleAspectFill : UIViewContentModeScaleAspectFit;
    } else if (value > 1.f) {
        contentMode = fill ? UIViewContentModeScaleAspectFill : UIViewContentModeScaleAspectFit;;
    }
    self.contentMode = contentMode;
}

@end

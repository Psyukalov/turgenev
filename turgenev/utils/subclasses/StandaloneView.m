//
//  StandaloneView.h
//
//
//  Created by Vladimir Psyukalov on 01.10.17.
//  Copyright © 2017 YOUROCK INC. All rights reserved.
//


#import "StandaloneView.h"


@implementation StandaloneView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadViewFromNib];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self loadViewFromNib];
    }
    return self;
}

- (void)loadViewFromNib {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class])
                                bundle:bundle];
    _subview = (UIView *)[nib instantiateWithOwner:self
                                           options:nil].firstObject;
    [self setBackgroundColor:_subview.backgroundColor];
    [_subview setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_subview];
    NSArray *attributes = @[@(NSLayoutAttributeLeft),
                            @(NSLayoutAttributeTop),
                            @(NSLayoutAttributeRight),
                            @(NSLayoutAttributeBottom)];
    for (NSNumber *attribute in attributes) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_subview
                                                         attribute:[attribute unsignedIntegerValue]
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:[attribute unsignedIntegerValue]
                                                        multiplier:1.f
                                                          constant:0.f]];
    }
}

@end

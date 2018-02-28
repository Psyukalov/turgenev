//
//  TViewController.m
//  turgenev
//
//  Created by Vladimir Psyukalov on 21.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "TViewController.h"

#import "Macros.h"

#import "UIView+Custom.h"


@interface TViewController ()

@property (strong, nonatomic) UIImage *image;

@end


@implementation TViewController

#pragma mark - Class methods

- (instancetype)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        _image = image;
    }
    return self;
}

- (void)didCloseButtonAction {
    NSLog(@"Did close button action;");
}

#pragma mark - Overriding

- (void)viewDidLoad {
    [super viewDidLoad];
    _backgroundImageView.image = _image;
}

#pragma mark - Actions

- (IBAction)closeButton_TUI:(UIButton *)sender {
    [self didCloseButtonAction];
}

@end

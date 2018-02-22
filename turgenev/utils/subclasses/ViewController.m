//
//  ViewController.m
//
//
//  Created by Vladimir Psyukalov on 07.12.17.
//  Copyright © 2017 YOUROCK INC. All rights reserved.
//


#import "ViewController.h"

/*
 *
 * Only for current project.
 *
 */

#import "UIView+Custom.h"


@interface ViewController ()

@end


@implementation ViewController

#pragma mark - Class methods

- (void)keyboardWillShow:(BOOL)show height:(CGFloat)height duration:(CGFloat)duration {
    NSLog(@"Keyboard will show: %@; Height: %1.2f; Duration: %1.2f;", show ? @"Yes" : @"No", height, duration);
}

#pragma mark - Overriding

- (BOOL)shouldAutorotate {
    if (self.presentedViewController) {
        return [self.presentedViewController shouldAutorotate];
    }
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.presentedViewController) {
        return [self.presentedViewController supportedInterfaceOrientations];
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(keyboardWillShow:)
                   name:UIKeyboardWillShowNotification
                 object:nil];
    [center addObserver:self
               selector:@selector(keyboardWillHide:)
                   name:UIKeyboardWillHideNotification
                 object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self
                      name:UIKeyboardWillShowNotification
                    object:nil];
    [center removeObserver:self
                      name:UIKeyboardWillHideNotification
                    object:nil];
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    UILabel *label = [UILabel new];
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont new],
                                 NSForegroundColorAttributeName : [UIColor whiteColor]};
    label.attributedText = [[NSAttributedString alloc] initWithString:self.title
                                                           attributes:attributes];
    [label sizeToFit];
    [label sizeToFit];
    self.navigationItem.titleView = label;
}

#pragma mark - Custom accessors

- (void)setImageNamed:(NSString *)imageNamed {
    _imageNamed = imageNamed;
    UIImageView *imageView = [UIImageView new];
    [imageView setImage:[UIImage imageNamed:_imageNamed]];
    [imageView sizeToFit];
    self.navigationItem.titleView = imageView;
}

#pragma mark - Other methods

- (void)keyboardWillShow:(NSNotification *)notification {
    CGFloat height = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [self keyboardWillShow:YES height:height duration:duration];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    CGFloat height = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [self keyboardWillShow:NO height:height duration:duration];
}

@end

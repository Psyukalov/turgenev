//
//  TViewController.h
//  turgenev
//
//  Created by Vladimir Psyukalov on 21.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "ViewController.h"


@interface TViewController : ViewController

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (weak, nonatomic) IBOutlet UIView *transparentView;

@property (weak, nonatomic) IBOutlet UIButton *closeButton;

- (instancetype)initWithImage:(UIImage *)image;

- (void)didCloseButtonAction;

@end

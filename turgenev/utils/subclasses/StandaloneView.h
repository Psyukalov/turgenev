//
//  StandaloneView.h
//
//
//  Created by Vladimir Psyukalov on 01.10.17.
//  Copyright © 2017 YOUROCK INC. All rights reserved.
//


#import <UIKit/UIKit.h>


@protocol StandaloneViewProtocol <NSObject>

@optional

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)(void))completion;

@end


@interface StandaloneView : UIView <StandaloneViewProtocol>

@property (strong, nonatomic) UIView *subview;

- (void)loadViewFromNib;

@end

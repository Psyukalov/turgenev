//
//  ImageCollectionViewCell.m
//  turgenev
//
//  Created by Vladimir Psyukalov on 13.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "ImageCollectionViewCell.h"

#import <SDWebImage/UIImageView+WebCache.h>

#import "UIView+Custom.h"
#import "UIImageView+Custom.h"

#import "VPActivityIndicatorView.h"


@interface ImageCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet VPActivityIndicatorView *activityIndicatorView;

@end


@implementation ImageCollectionViewCell

- (void)setImage:(UIImage *)image {
    _image = image;
    _imageView.image = _image;
    [_imageView contentModeWithFill:YES];
}

- (void)setImageURL:(NSString *)imageURL {
    [_activityIndicatorView play];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageURL]
                         completed:^(UIImage * _Nullable image,
                                     NSError * _Nullable error,
                                     SDImageCacheType cacheType,
                                     NSURL * _Nullable imageURL) {
                             [_imageView contentModeWithFill:YES];
                             [_activityIndicatorView stop];
                         }];
}

@end

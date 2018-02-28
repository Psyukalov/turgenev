//
//  PlaceStandaloneView.m
//  turgenev
//
//  Created by Vladimir Psyukalov on 19.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "PlaceStandaloneView.h"

#import "Macros.h"

#import <SDWebImage/UIImageView+WebCache.h>

#import "iCarousel.h"

#import "UIView+Custom.h"
#import "UILabel+Custom.h"
#import "UIImageView+Custom.h"


#define kTopInset (94.f)


@interface PlaceStandaloneView () <iCarouselDataSource, iCarouselDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet iCarousel *carouselView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *previewTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *mainTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@property (weak, nonatomic) IBOutlet UIButton *routeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentsButton;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gradientImageView;

@end


@implementation PlaceStandaloneView

#pragma mark - Overriding

- (void)loadViewFromNib {
    [super loadViewFromNib];
    [self setup];
    [self localize];
}

#pragma mark - Custom accessors

- (void)setPlace:(Place *)place {
    _place = place;
    [self fill];
}

#pragma mark - iCarouselDataSource, iCarouselDelegate

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    NSUInteger count = _place.imageURLs.count;
    _pageControl.numberOfPages = count == 0 ? 1 : count;
    return count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    if (!view) {
        view = [UIView new];
        view.frame = carousel.bounds;
    }
    return view;
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel {
    _pageControl.currentPage = carousel.currentItemIndex;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    // TODO:
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentHeight = scrollView.contentSize.height;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY + height >= contentHeight) {
        [scrollView setContentOffset:CGPointMake(0.f, contentHeight - height) animated:NO];
    }
}

#pragma mark - Actions

- (IBAction)routeButton_TUI:(UIButton *)sender {
    [self didSelectAction:PlaceStandaloneViewActionRoute];
}

- (IBAction)commentsButton_TUI:(UIButton *)sender {
    [self didSelectAction:PlaceStandaloneViewActionComment];
}

#pragma mark - Other methods

- (void)setup {
    _scrollView.contentInset = UIEdgeInsetsMake(kTopInset, 0.f, 0.f, 0.f);
    [self shadowWithOffset:CGSizeZero];
    [self setHidden:YES animated:NO completion:nil];
    for (UIButton *button in @[_routeButton, _commentsButton]) {
        [button cornerRadius:button.frame.size.height / 2.f];
        [button borderWithColor:[UIColor whiteColor]];
        [button shadowWithOffset:CGSizeZero];
    }
}

- (void)localize {
    _infoLabel.text = LOCALIZE(@"isv_title_0");
    _ratingLabel.text = LOCALIZE(@"isv_title_1");
    _distanceLabel.text = LOCALIZE(@"isv_title_2");
    [_routeButton setTitle:LOCALIZE(@"isv_button_0") forState:UIControlStateNormal];
    [_commentsButton setTitle:LOCALIZE(@"isv_button_1") forState:UIControlStateNormal];
}

- (void)fill {
    _nameLabel.text = _place.name;
    _previewTextLabel.text = _place.previewText;
    _mainTextLabel.text = _place.mainText;
    _addressLabel.text = _place.address;
    _ratingValueLabel.text = [NSString stringWithFormat:@"%1.1f", _place.rating];
    _distanceValueLabel.text = [NSString stringWithFormat:@"%1.0f", 0.f];
    NSString *imageURL;
    @try {
        imageURL = _place.imageURLs.firstObject;
    }
    @finally { }
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] completed:^(UIImage * _Nullable image,
                                                                              NSError * _Nullable error,
                                                                              SDImageCacheType cacheType,
                                                                              NSURL * _Nullable imageURL) {
        [_imageView contentModeWithFill:YES];
    }];
    NSString *imageNamed = [NSString stringWithFormat:@"gradient_%ld_i.png", (unsigned long)_place.type];
    _gradientImageView.image = [UIImage imageNamed:imageNamed];
    [_carouselView reloadData];
}

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)(void))completion {
    CGAffineTransform transform = hidden ? CGAffineTransformMakeTranslation(0.f, HEIGHT) : CGAffineTransformIdentity;
    if (animated) {
        [UIView animate:^{
            self.transform = transform;
        }
             completion:^{
                 if (hidden) {
                     _scrollView.contentOffset = CGPointMake(0.f, -_scrollView.contentInset.top);
                 }
                 if (completion) {
                     completion ();
                 }
             }
               duration:.64f];
    } else {
        if (hidden) {
            _scrollView.contentOffset = CGPointMake(0.f, -_scrollView.contentInset.top);
        }
        self.transform = transform;
        if (completion) {
            completion ();
        }
    }
}

- (void)didSelectAction:(PlaceStandaloneViewAction)action {
    if ([_delegate respondsToSelector:@selector(placeStandaloneView:didSelectAction:)]) {
        [_delegate placeStandaloneView:self didSelectAction:action];
    }
}

@end

//
//  PlaceStandaloneView.m
//  turgenev
//
//  Created by Vladimir Psyukalov on 19.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "PlaceStandaloneView.h"

#import "Macros.h"

#import "iCarousel.h"

#import "UIView+Custom.h"
#import "UILabel+Custom.h"


#define kTopInset (94.f)


@interface PlaceStandaloneView () <iCarouselDataSource, iCarouselDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet iCarousel *carouselView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *previewTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *mainTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@property (weak, nonatomic) IBOutlet UIButton *routeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentsButton;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gradientImageView;

@property (strong, nonatomic) Place *place;

@end


@implementation PlaceStandaloneView

- (void)loadViewFromNib {
    [super loadViewFromNib];
    [self setup];
    [self localize];
}

#pragma mark - iCarouselDataSource, iCarouselDelegate

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return _place.imageURLs.count;
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

- (void)localize {
    _ratingLabel.text = LOCALIZE(@"isv_title_0");
    _distanceLabel.text = LOCALIZE(@"isv_title_1");
    [_routeButton setTitle:LOCALIZE(@"isv_button_0") forState:UIControlStateNormal];
    [_commentsButton setTitle:LOCALIZE(@"isv_button_1") forState:UIControlStateNormal];
}

@end

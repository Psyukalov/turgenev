//
//  TableView.m
//
//
//  Created by Vladimir Psyukalov on 07.12.17.
//  Copyright © 2017 YOUROCK INC. All rights reserved.
//


#import "TableView.h"


@interface TableView ()

@property (strong, nonatomic) NSMutableArray<NSString *> *cellReuseIdentifiers;
@property (strong, nonatomic) NSMutableArray<NSString *> *viewReuseIdentifiers;

@property (assign, nonatomic) BOOL headerSlidingViewHidden;

@property (assign, nonatomic) CGFloat offsetY;

@end


@implementation TableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _cellReuseIdentifiers = [NSMutableArray new];
    _viewReuseIdentifiers = [NSMutableArray new];
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self
                            action:@selector(refreshControl_VC)
                  forControlEvents:UIControlEventValueChanged];
    self.tableFooterView = [UIView new];
    _canHideSlidingView = YES;
    self.alwaysBounceVertical = NO;
}

- (void)setHeaderSlidingView:(UIView *)headerSlidingView {
    _headerSlidingView = headerSlidingView;
    [self.superview insertSubview:headerSlidingView
                     aboveSubview:self];
    UIEdgeInsets edgeInsets = self.contentInset;
    edgeInsets.top = headerSlidingView.frame.size.height;
    self.contentInset = edgeInsets;
    self.scrollIndicatorInsets = edgeInsets;
}

- (void)setContentSize:(CGSize)contentSize {
    [super setContentSize:contentSize];
    if ([self.delegate respondsToSelector:@selector(tableView:didChangeContentSize:)]) {
        [(id)self.delegate tableView:self didChangeContentSize:contentSize];
    }
}

- (void)reloadData {
    [self reloadDataAnimated:NO];
}

- (void)reloadDataAnimated:(BOOL)animated {
    [self reloadDataAnimated:animated
                  completion:nil];
}

- (void)reloadDataAnimated:(BOOL)animated
                completion:(void (^)(void))completion {
    [super reloadData];
    if (animated) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setCellsHidden:YES
                        animated:NO
                      completion:nil];
            [self setCellsHidden:NO
                        animated:YES
                      completion:^{
                          if (completion) {
                              completion();
                          }
                      }];
        });
    }
}

- (void)setTitle:(NSString *)title withFont:(UIFont *)font andColor:(UIColor *)color {
    [self setTitle:title withFont:font andColor:color insets:UIEdgeInsetsMake(16.f, 16.f, 16.f, 16.f)];
}

- (void)setTitle:(NSString *)title withFont:(UIFont *)font andColor:(UIColor *)color insets:(UIEdgeInsets)insets {
    UILabel *label = [UILabel new];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    label.font = font;
    label.textColor = color;
    CGFloat width = UIScreen.mainScreen.bounds.size.width;
    CGSize size = [label sizeThatFits:CGSizeMake(width - insets.left - insets.right, FLT_MAX)];
    size.height += insets.top + insets.bottom;
    label.frame = CGRectMake(0.f, 0.f, width, size.height);
    self.tableHeaderView = label;
}

- (void)registerCellClass:(Class)cellClass {
    NSString *cellReuseIdentifier = NSStringFromClass(cellClass);
    [_cellReuseIdentifiers addObject:cellReuseIdentifier];
    [self registerNib:[UINib nibWithNibName:cellReuseIdentifier bundle:nil] forCellReuseIdentifier:cellReuseIdentifier];
}

- (void)registerViewClass:(Class)viewClass {
    NSString *viewReuseIdentifier = NSStringFromClass(viewClass);
    [_viewReuseIdentifiers addObject:viewReuseIdentifier];
    [self registerNib:[UINib nibWithNibName:viewReuseIdentifier bundle:nil] forHeaderFooterViewReuseIdentifier:viewReuseIdentifier];
}

- (nullable __kindof UITableViewCell *)dequeueReusableCellWithIndex:(NSUInteger)index {
    return [self dequeueReusableCellWithIdentifier:_cellReuseIdentifiers[index]];
}

- (nullable __kindof UIView *)dequeueReusableViewWithIndex:(NSUInteger)index {
    return [self dequeueReusableHeaderFooterViewWithIdentifier:_viewReuseIdentifiers[index]];
}

- (void)refreshControl_VC {
    [self.refreshControl beginRefreshing];
    if ([self.delegate respondsToSelector:@selector(didRefreshControlStartInTableView:)]) {
        [(id)self.delegate didRefreshControlStartInTableView:self];
    }
}

- (void)beginRefreshing {
    [self.refreshControl beginRefreshing];
}

- (void)endRefreshing {
    [self.refreshControl endRefreshing];
}

- (void)setContentOffset:(CGPoint)contentOffset {
    [super setContentOffset:contentOffset];
    CGFloat y = self.contentOffset.y;
    if (y < 0.f) {
        return;
    }
    if (self.contentSize.height - y < self.frame.size.height) {
        if ([self.delegate respondsToSelector:@selector(didScrollToBottomInTableView:)]) {
            [(id)self.delegate didScrollToBottomInTableView:self];
        }
        return;
    }
    if (!_canHideSlidingView) {
        return;
    }
    if (ABS(y - _offsetY) < _headerSlidingView.frame.size.height) {
        return;
    }
    [self setHeaderSlidingViewHidden:y > _offsetY
                            animated:YES];
    _offsetY = y;
}

- (void)setHeaderSlidingViewHidden:(BOOL)hidden
                          animated:(BOOL)animated {
    if (_headerSlidingViewHidden == hidden) {
        return;
    }
    _headerSlidingViewHidden = hidden;
    CGAffineTransform transform = hidden ? CGAffineTransformMakeTranslation(0.f, -_headerSlidingView.frame.size.height) : CGAffineTransformIdentity;
    if (animated) {
        [UIView animateWithDuration:.32f
                              delay:0.f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             _headerSlidingView.transform = transform;
                         }
                         completion:nil];
    } else {
        _headerSlidingView.transform = transform;
    }
}

- (void)setCellsHidden:(BOOL)hidden
              animated:(BOOL)animated {
    [self setCellsHidden:hidden
                animated:animated
              completion:nil];
}

- (void)setCellsHidden:(BOOL)hidden
              animated:(BOOL)animated
            completion:(void (^)(void))completion {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.hidden = hidden && !animated;
        if (self.visibleCells.count > 0) {
            CGFloat alpha = hidden ? 0.f : 1.f;
            for (NSUInteger i = 0; i <= self.visibleCells.count - 1; i++) {
                UITableViewCell *cell = self.visibleCells[i];
                if (animated) {
                    [UIView animateWithDuration:.64f
                                          delay:i * .08f
                                        options:UIViewAnimationOptionCurveEaseInOut
                                     animations:^{
                                         cell.alpha = alpha;
                                     }
                                     completion:^(BOOL finished) {
                                         if (i == self.visibleCells.count - 1) {
                                             if (completion) {
                                                 completion();
                                             }
                                         }
                                     }];
                } else {
                    cell.alpha = alpha;
                    if (i == self.visibleCells.count - 1) {
                        if (completion) {
                            completion();
                        }
                    }
                }
            }
        } else if (completion) {
            completion();
        }
    });
}

@end

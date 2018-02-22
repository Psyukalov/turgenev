//
//  TableView.h
//
//
//  Created by Vladimir Psyukalov on 07.12.17.
//  Copyright © 2017 YOUROCK INC. All rights reserved.
//


#import <UIKit/UIKit.h>


@class TableView;


@protocol TableViewDelegate <UITableViewDelegate>

@optional

- (void)didRefreshControlStartInTableView:(TableView *)tableView;

- (void)didScrollToBottomInTableView:(TableView *)tableView;

- (void)tableView:(TableView *)tableView didChangeContentSize:(CGSize)contentSize;

@end


@interface TableView : UITableView

@property (strong, nonatomic) UIView *headerSlidingView;

@property (assign, nonatomic) BOOL canHideSlidingView;



- (void)setup;

- (void)reloadDataAnimated:(BOOL)animated;
- (void)reloadDataAnimated:(BOOL)animated completion:(void (^)(void))completion;

- (void)registerCellClass:(Class)cellClass;
- (void)registerViewClass:(Class)viewClass;

- (void)setTitle:(NSString *)title withFont:(UIFont *)font andColor:(UIColor *)color;
- (void)setTitle:(NSString *)title withFont:(UIFont *)font andColor:(UIColor *)color insets:(UIEdgeInsets)insets;

- (__kindof UITableViewCell *)dequeueReusableCellWithIndex:(NSUInteger)index;
- (__kindof UIView *)dequeueReusableViewWithIndex:(NSUInteger)index;

- (void)beginRefreshing;
- (void)endRefreshing;

- (void)setCellsHidden:(BOOL)hidden animated:(BOOL)animated;
- (void)setCellsHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)(void))completion;

@end

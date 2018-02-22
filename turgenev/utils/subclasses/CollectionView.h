//
//  CollectionView.h
//
//
//  Created by Vladimir Psyukalov on 26.12.17.
//  Copyright © 2017 YOUROCK INC. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface CollectionView : UICollectionView

- (void)setup;

- (void)registerCellClass:(Class)cellClass;

- (void)reloadDataAnimated:(BOOL)animated;
- (void)reloadDataAnimated:(BOOL)animated completion:(void (^)(void))completion;

- (__kindof UICollectionViewCell *)dequeueReusableCellWithIndex:(NSUInteger)index forIndexPath:(NSIndexPath *)indexPath;

- (void)setCellsHidden:(BOOL)hidden animated:(BOOL)animated;
- (void)setCellsHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)(void))completion;

@end

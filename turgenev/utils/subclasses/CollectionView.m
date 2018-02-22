//
//  CollectionView.m
//
//
//  Created by Vladimir Psyukalov on 26.12.17.
//  Copyright © 2017 YOUROCK INC. All rights reserved.
//


#import "CollectionView.h"


@interface CollectionView ()

@property (strong, nonatomic) NSMutableArray<NSString *> *cellReuseIdentifiers;

@end


@implementation CollectionView

#pragma mark - Overriding

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

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - Custom methods

- (void)setup {
    _cellReuseIdentifiers = [NSMutableArray new];
    self.alwaysBounceVertical = NO;
}

- (void)registerCellClass:(Class)cellClass {
    NSString *cellReuseIdentifier = NSStringFromClass(cellClass);
    [_cellReuseIdentifiers addObject:cellReuseIdentifier];
    [self registerNib:[UINib nibWithNibName:cellReuseIdentifier bundle:nil] forCellWithReuseIdentifier:cellReuseIdentifier];
}

- (void)reloadData {
    [self reloadDataAnimated:NO];
}

- (void)reloadDataAnimated:(BOOL)animated {
    [self reloadDataAnimated:animated completion:nil];
}

- (void)reloadDataAnimated:(BOOL)animated completion:(void (^)(void))completion {
    if (animated) {
        self.hidden = YES;
    }
    [super reloadData];
    if (animated) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setCellsHidden:YES animated:NO completion:nil];
            self.hidden = NO;
            [self setCellsHidden:NO animated:YES completion:^{
                if (completion) {
                    completion();
                }
            }];
        });
    }
}

- (__kindof UICollectionViewCell *)dequeueReusableCellWithIndex:(NSUInteger)index
                                                   forIndexPath:(NSIndexPath *)indexPath {
    return [self dequeueReusableCellWithReuseIdentifier:_cellReuseIdentifiers[index] forIndexPath:indexPath];
}

- (void)setCellsHidden:(BOOL)hidden animated:(BOOL)animated {
    [self setCellsHidden:hidden animated:animated completion:nil];
}

- (void)setCellsHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)(void))completion {
    [super setContentOffset:CGPointZero animated:NO];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.hidden = hidden && !animated;
        if (self.visibleCells.count > 0) {
            CGFloat alpha = hidden ? 0.f : 1.f;
            NSArray<NSIndexPath *> *indexPaths = [self indexPathsForVisibleItems];
            for (NSUInteger i = 0; i <= self.visibleCells.count - 1; i++) {
                UICollectionViewCell *cell = self.visibleCells[indexPaths[i].row];
                if (animated) {
                    [UIView animateWithDuration:.32f
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
        } else {
            if (completion) {
                completion();
            }
        }
    });
}

@end

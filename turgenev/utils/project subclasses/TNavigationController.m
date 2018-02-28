//
//  TNavigationController.m
//  turgenev
//
//  Created by Vladimir Psyukalov on 22.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "TNavigationController.h"

#import "MapViewController.h"


@interface TNavigationController ()

@property (strong, nonatomic) MapViewController *mapVC;

@end


@implementation TNavigationController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _mapVC = [MapViewController new];
    self.viewControllers = @[_mapVC];
    [self setNavigationBarHidden:YES];
}

@end

//
//  Settings.h
//  turgenev
//
//  Created by Vladimir Psyukalov on 06.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "TObject.h"


@interface Settings : NSObject <TObjectProtocol, NSCoding>

@property (assign, nonatomic) BOOL neededNotificationQuests;
@property (assign, nonatomic) BOOL neededNotificationInteresting;
@property (assign, nonatomic) BOOL neededNotificationPromotions;
@property (assign, nonatomic) BOOL neededNotificationEvents;

+ (instancetype)shared __attribute__((unavailable("This protocol method is not implemented.")));

- (void)synchronize __attribute__((unavailable("This protocol method is not implemented.")));

@end

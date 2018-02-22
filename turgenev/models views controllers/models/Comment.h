//
//  Comment.h
//  turgenev
//
//  Created by Vladimir Psyukalov on 09.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "TObject.h"

#import "User.h"


@interface Comment : NSObject <TObjectProtocol, NSCoding>

@property (assign, nonatomic) NSUInteger identifier;

@property (strong, nonatomic) NSDate *date;

@property (strong, nonatomic) NSString *stringDate;
@property (strong, nonatomic) NSString *text;

@property (strong, nonatomic) NSArray<NSNumber *> *likeIdentifiers;
@property (strong, nonatomic) NSArray<NSNumber *> *dislikeIdentifiers;

@property (strong, nonatomic) User *sender;
@property (strong, nonatomic) User *receiver;

+ (instancetype)shared __attribute__((unavailable("This protocol method is not implemented.")));

- (void)save __attribute__((unavailable("This protocol method is not implemented.")));
- (void)load __attribute__((unavailable("This protocol method is not implemented.")));

- (void)synchronize __attribute__((unavailable("This protocol method is not implemented.")));

@end

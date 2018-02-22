//
//  Place.h
//  turgenev
//
//  Created by Vladimir Psyukalov on 08.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "TObject.h"

#import "Comment.h"
#import "Media.h"


typedef NS_ENUM(NSUInteger, PlaceType) {
    PlaceTypeQuest = 0,
    PlaceTypeIntresting,
    PlaceTypePromotions,
    PlaceTypeEvent
};


@interface Place : NSObject <TObjectProtocol, NSCoding>

@property (assign, nonatomic) NSUInteger identifier;

@property (assign, nonatomic) PlaceType type;

@property (assign, nonatomic) double latitude;
@property (assign, nonatomic) double longitude;
@property (assign, nonatomic) double rating;

@property (assign, nonatomic) BOOL isVisited;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *previewText;
@property (strong, nonatomic) NSString *mainText;

@property (strong, nonatomic) NSArray<NSString *> *imageURLs;

@property (strong, nonatomic) NSMutableArray<Comment *> *comments;

@property (strong, nonatomic) Media *media;

@property (strong, nonatomic) NSData *data;

+ (instancetype)shared __attribute__((unavailable("This protocol method is not implemented.")));

- (void)save __attribute__((unavailable("This protocol method is not implemented.")));
- (void)load __attribute__((unavailable("This protocol method is not implemented.")));

- (void)synchronize __attribute__((unavailable("This protocol method is not implemented.")));

@end

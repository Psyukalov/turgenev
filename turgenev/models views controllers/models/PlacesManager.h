//
//  PlacesManager.h
//  turgenev
//
//  Created by Vladimir Psyukalov on 08.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "TObject.h"

#import "Place.h"


@interface PlacesManager : NSObject <TObjectProtocol, NSCoding>

@property (strong, nonatomic) NSString *version;

@property (strong, nonatomic) NSMutableArray<Place *> *places;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary __attribute__((unavailable("This protocol method is not implemented.")));

@end

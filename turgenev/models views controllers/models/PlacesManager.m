//
//  PlacesManager.m
//  turgenev
//
//  Created by Vladimir Psyukalov on 08.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "PlacesManager.h"

#import "SessionManager.h"


#define kPlacesKey (@"places_manager_places_key")
#define kVersionKey (@"places_manager_version_key")

#define kUserDefaultsPlacesManagerKey (@"user_defaults_places_manager_key")


@implementation PlacesManager

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _version = [aDecoder decodeObjectForKey:kVersionKey];
        _places = [aDecoder decodeObjectForKey:kPlacesKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_version forKey:kVersionKey];
    [aCoder encodeObject:_places forKey:kPlacesKey];
}

- (void)save {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:data forKey:kUserDefaultsPlacesManagerKey];
    [userDefaults synchronize];
}

- (void)load {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:kUserDefaultsPlacesManagerKey];
    PlacesManager *placesManager = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (placesManager) {
        _version = placesManager.version;
        _places = placesManager.places;
    }
}

- (void)synchronize {
    // TODO:
    [[SessionManager manager] GET:nil
                          success:^(id responce) {
                              // TODO:
                          }
                          failure:^(NSError *error) {
                              // TODO:
                          }];
}

@end

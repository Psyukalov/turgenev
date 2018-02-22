//
//  User.m
//  turgenev
//
//  Created by Vladimir Psyukalov on 06.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "User.h"


#define kIdentifierKey (@"user_identifier_key")
#define kNameKey (@"user_name_key")
#define kSurnameKey (@"user_surname_key")
#define kImageURLKey (@"user_image_url_key")

#define kUserDefaulstUserKey (@"user_defaults_user_key")


@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _identifier = [dictionary[@"_identifier"] integerValue];
        _name = dictionary[@"name"];
        _surname = dictionary[@"surname"];
        _imageURL = dictionary[@"imageURL"];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _identifier = [aDecoder decodeIntegerForKey:kIdentifierKey];
        _name = [aDecoder decodeObjectForKey:kNameKey];
        _surname = [aDecoder decodeObjectForKey:kSurnameKey];
        _imageURL = [aDecoder decodeObjectForKey:kImageURLKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:_identifier forKey:kIdentifierKey];
    [aCoder encodeObject:_name forKey:kNameKey];
    [aCoder encodeObject:_surname forKey:kSurnameKey];
    [aCoder encodeObject:_imageURL forKey:kImageURLKey];
}

- (void)save {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:data forKey:kUserDefaulstUserKey];
    [userDefaults synchronize];
}

- (void)load {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:kUserDefaulstUserKey];
    User *user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (user) {
        _name = user.name;
        _surname = user.surname;
        _imageURL = user.imageURL;
    }
}

@end

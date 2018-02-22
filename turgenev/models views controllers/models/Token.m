//
//  Token.m
//  turgenev
//
//  Created by Vladimir Psyukalov on 08.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "Token.h"


#define kAccessTokenKey (@"token_access_token_key")

#define kUserDefaultsTokenKey (@"user_defaults_token_key")


@implementation Token

+ (instancetype)shared {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self class] new];
    });
    return instance;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _accessToken = [aDecoder decodeObjectForKey:kAccessTokenKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_accessToken forKey:kAccessTokenKey];
}

- (void)save {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:data forKey:kUserDefaultsTokenKey];
    [userDefaults synchronize];
}

- (void)load {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:kUserDefaultsTokenKey];
    Token *token = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (token) {
        _accessToken = token.accessToken;
    }
}

@end

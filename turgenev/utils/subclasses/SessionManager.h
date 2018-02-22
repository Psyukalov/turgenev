//
//  SessionManager.h
//
//
//  Created by Vladimir Psyukalov on 14.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import <AFNetworking/AFNetworking.h>


#define kBaseURLString (@"")

#define kStringTokenKey (@"")


@interface SessionManager : AFHTTPSessionManager

+ (instancetype)manager;

- (void)GET:(NSString *)URLString success:(void (^)(id responce))success failure:(void (^)(NSError *error))failure;
- (void)POST:(NSString *)URLString success:(void (^)(id responce))success failure:(void (^)(NSError *error))failure;
- (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id responce))success failure:(void (^)(NSError *error))failure;
- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id responce))success failure:(void (^)(NSError *error))failure;

@end

//
//  SessionManager.m
//  turgenev
//
//  Created by Vladimir Psyukalov on 14.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "SessionManager.h"

#import "Token.h"


@implementation SessionManager

+ (instancetype)manager {
    SessionManager *manager = [[[self class] alloc] initWithBaseURL:[NSURL URLWithString:kBaseURLString]];
    if (manager) {
        Token *token = [Token shared];
        if (token.accessToken) {
            [manager.requestSerializer setValue:token.accessToken forHTTPHeaderField:kStringTokenKey];
        }
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    }
    return manager;
}

- (void)GET:(NSString *)URLString success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [self GET:URLString parameters:nil success:success failure:failure];
}

- (void)POST:(NSString *)URLString success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [self POST:URLString parameters:nil success:success failure:failure];
}

- (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [super GET:URLString
    parameters:parameters
      progress:nil
       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           if (success) {
               success(responseObject);
           }
       }
       failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           if (failure) {
               failure(error);
           }
       }];
}

- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [super POST:URLString
     parameters:parameters
       progress:nil
        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
        }
        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
}

@end

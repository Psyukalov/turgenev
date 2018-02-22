//
//  UserManager.m
//  turgenev
//
//  Created by Vladimir Psyukalov on 19.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "UserManager.h"

#import "Token.h"

#import "SessionManager.h"


@implementation UserManager

- (void)authorizationWithEmail:(NSString *)email password:(NSString *)password {
    [self authorizationWithEmail:email password:password];
}

- (void)authorizationWithEmail:(NSString *)email password:(NSString *)password completion:(void (^)(id, NSError *))completion {
    [[SessionManager manager] GET:nil
                       parameters:@{@"email" : email, @"password" : password}
                          success:^(id responce) {
                              @try {
                                  Token *token = [Token shared];
                                  token.accessToken = responce[@"accessToken"];
                                  [token save];
                              }
                              @finally {
                                  if (completion) {
                                      completion(responce, nil);
                                  }
                                  [self sendMessage:kAuthorizationMessage response:responce error:nil];
                              }
                          }
                          failure:^(NSError *error) {
                              if (completion) {
                                  completion(nil, error);
                              }
                              [self sendMessage:kAuthorizationMessage response:nil error:error];
                          }];
}

@end

//
//  UserManager.h
//  turgenev
//
//  Created by Vladimir Psyukalov on 19.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "CustomObject.h"


#define kAuthorizationMessage (@"user_manager_authorization_message")


@interface UserManager : CustomObject

- (void)authorizationWithEmail:(NSString *)email password:(NSString *)password;
- (void)authorizationWithEmail:(NSString *)email password:(NSString *)password completion:(void (^)(id response, NSError *error))completion;

@end

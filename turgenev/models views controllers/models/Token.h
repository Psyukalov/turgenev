//
//  Token.h
//  turgenev
//
//  Created by Vladimir Psyukalov on 08.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "TObject.h"


@interface Token : NSObject <TObjectProtocol, NSCoding>

@property (strong, nonatomic) NSString *accessToken;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary __attribute__((unavailable("This protocol method is not implemented.")));

- (void)synchronize __attribute__((unavailable("This protocol method is not implemented.")));

@end

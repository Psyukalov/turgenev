//
//  User.h
//  turgenev
//
//  Created by Vladimir Psyukalov on 06.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "TObject.h"


@interface User : NSObject <TObjectProtocol, NSCoding>

@property (assign, nonatomic) NSUInteger identifier;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *surname;

@property (strong, nonatomic) NSString *imageURL;

- (void)synchronize __attribute__((unavailable("This protocol method is not implemented.")));

@end

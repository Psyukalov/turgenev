//
//  Media.h
//  turgenev
//
//  Created by Vladimir Psyukalov on 14.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "TObject.h"


@interface Media : NSObject <TObjectProtocol, NSCoding>

@property (strong, nonatomic) NSDictionary *lottieJSON;

@property (strong, nonatomic) NSData *audio;

+ (instancetype)shared __attribute__((unavailable("This protocol method is not implemented.")));

- (void)save __attribute__((unavailable("This protocol method is not implemented.")));
- (void)load __attribute__((unavailable("This protocol method is not implemented.")));

- (void)synchronize __attribute__((unavailable("This protocol method is not implemented.")));

@end

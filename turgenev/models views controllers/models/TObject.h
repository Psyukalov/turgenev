//
//  TObject.h
//  turgenev
//
//  Created by Vladimir Psyukalov on 06.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import <Foundation/Foundation.h>


@protocol TObjectProtocol <NSObject>

@optional

+ (instancetype)shared;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (void)save;
- (void)load;

- (void)synchronize;

@end


@interface TObject : NSObject

@end

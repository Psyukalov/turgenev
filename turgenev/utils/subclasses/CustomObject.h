//
//  CustomObject.h
//
//
//  Created by Vladimir Psyukalov on 14.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import <Foundation/Foundation.h>


@class CustomObject;


@protocol CustomObjectObserverProtocol <NSObject>

@optional

- (void)object:(CustomObject *)object didSendMessage:(NSString *)message;
- (void)object:(CustomObject *)object didSendMessage:(NSString *)message response:(id)response error:(NSError *)error;

@end


@interface CustomObject : NSObject

- (void)addObserver:(id<CustomObjectObserverProtocol>)observer;
- (void)removeObserver:(id<CustomObjectObserverProtocol>)observer;

- (void)sendMessage:(NSString *)message;
- (void)sendMessage:(NSString *)message response:(id)response error:(NSError *)error;

@end

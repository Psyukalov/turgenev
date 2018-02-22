//
//  CustomObject.m
//
//
//  Created by Vladimir Psyukalov on 14.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "CustomObject.h"


@interface CustomObject ()

@property (strong, nonatomic) NSMutableArray<id<CustomObjectObserverProtocol>> *observers;

@end


@implementation CustomObject

#pragma mark - Overriding

- (instancetype)init {
    self = [super init];
    if (self) {
        _observers = [NSMutableArray new];
    }
    return self;
}

#pragma mark - Custom methods

- (void)addObserver:(id<CustomObjectObserverProtocol>)observer {
    BOOL isExist = NO;
    for (id<CustomObjectObserverProtocol> existObserver in _observers) {
        if ([existObserver isEqual:observer]) {
            isExist = YES;
            break;
        }
    }
    if (!isExist) {
        [_observers addObject:observer];
    }
}

- (void)removeObserver:(id<CustomObjectObserverProtocol>)observer {
    [_observers removeObject:observer];
}

- (void)sendMessage:(NSString *)message {
    [self sendMessage:message response:nil error:nil];
}

- (void)sendMessage:(NSString *)message response:(id)response error:(NSError *)error {
    for (id<CustomObjectObserverProtocol> observer in _observers) {
        if ([observer respondsToSelector:@selector(object:didSendMessage:)]) {
            [observer object:self didSendMessage:message];
        }
        if ([observer respondsToSelector:@selector(object:didSendMessage:response:error:)]) {
            [observer object:self didSendMessage:message response:response error:error];
        }
    }
}

@end

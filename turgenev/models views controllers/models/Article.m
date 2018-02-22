//
//  Article.m
//  turgenev
//
//  Created by Vladimir Psyukalov on 09.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "Article.h"


@implementation Article

- (void)object:(CustomObject *)object didSendMessage:(NSString *)message {
    NSLog(@"it is article %@", message);
}

@end

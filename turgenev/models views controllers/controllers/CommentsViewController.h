//
//  CommentsViewController.h
//  turgenev
//
//  Created by Vladimir Psyukalov on 20.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "TViewController.h"

#import "Comment.h"


@interface CommentsViewController : TViewController

- (instancetype)initWithImage:(UIImage *)image comments:(NSMutableArray<Comment *> *)comments;

@end

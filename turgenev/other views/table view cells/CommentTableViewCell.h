//
//  CommentTableViewCell.h
//  turgenev
//
//  Created by Vladimir Psyukalov on 21.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import <UIKit/UIKit.h>


@class CommentTableViewCell;


@protocol CommentTableViewCellDelegate <NSObject>

@optional

- (void)tableViewCell:(CommentTableViewCell *)tableViewCell didSelectAnswerForIndexPath:(NSIndexPath *)indexPath;

- (void)tableViewCell:(CommentTableViewCell *)tableViewCell didSelectLike:(BOOL)selected forIndexPath:(NSIndexPath *)indexPath;

@end


@interface CommentTableViewCell : UITableViewCell

@property (weak, nonatomic) id<CommentTableViewCellDelegate> delegate;

@property (strong, nonatomic) NSIndexPath *indexPath;

@property (strong, nonatomic) UIImage *image;

@property (strong, nonatomic) NSString *imageURL;

@property (strong, nonatomic) NSString *sender;
@property (strong, nonatomic) NSString *receiver;

@property (strong, nonatomic) NSString *date;

@property (strong, nonatomic) NSString *comment;

@property (assign, nonatomic) BOOL isLike;

@property (assign, nonatomic) NSUInteger likesCount;

@end

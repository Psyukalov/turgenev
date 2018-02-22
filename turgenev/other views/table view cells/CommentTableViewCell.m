//
//  CommentTableViewCell.m
//  turgenev
//
//  Created by Vladimir Psyukalov on 21.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "CommentTableViewCell.h"

#import "Macros.h"

#import <SDWebImage/UIImageView+WebCache.h>

#import "UIView+Custom.h"
#import "UIImageView+Custom.h"


@interface CommentTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *senderImageView;

@property (weak, nonatomic) IBOutlet UILabel *senderLabel;
@property (weak, nonatomic) IBOutlet UILabel *receiverLabel;

@property (weak, nonatomic) IBOutlet UILabel *answerLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (weak, nonatomic) IBOutlet UILabel *likesCountLabel;

@property (weak, nonatomic) IBOutlet UIButton *answerButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@end


@implementation CommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_senderImageView cornerRadius:_senderImageView.frame.size.height / 2.f];
    _answerLabel.text = LOCALIZE(@"ctvc_title_0");
    [_answerButton setTitle:LOCALIZE(@"ctvc_title_1") forState:UIControlStateNormal];
}

#pragma mark - Custom accessors

- (void)setImage:(UIImage *)image {
    _image = image;
    _senderImageView.image = _image;
    [_senderImageView contentModeWithFill:YES];
}

- (void)setImageURL:(NSString *)imageURL {
    [_senderImageView sd_setImageWithURL:[NSURL URLWithString:imageURL] completed:^(UIImage * _Nullable image,
                                                                                    NSError * _Nullable error,
                                                                                    SDImageCacheType cacheType,
                                                                                    NSURL * _Nullable imageURL) {
        [_senderImageView contentModeWithFill:YES];
    }];
}

- (void)setSender:(NSString *)sender {
    _sender = sender;
    _senderLabel.text = _sender;
}

- (void)setReceiver:(NSString *)receiver {
    _receiver = receiver;
    _receiverLabel.text = _receiver;
    BOOL hidden = _receiver == nil;
    _answerLabel.hidden = hidden;
    _receiverLabel.hidden = hidden;
}

- (void)setDate:(NSString *)date {
    _date = date;
    _dateLabel.text = _date;
}

- (void)setComment:(NSString *)comment {
    _comment = comment;
    _commentLabel.text = _comment;
}

- (void)setIsLike:(BOOL)isLike {
    _isLike = isLike;
    _likeButton.selected = _isLike;
}

- (void)setLikesCount:(NSUInteger)likesCount {
    _likesCount = likesCount;
    _likesCountLabel.text = [NSString stringWithFormat:@"%ld", (unsigned long)_likesCount];
}

#pragma mark - Action

- (IBAction)answerButton_TUI:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(tableViewCell:didSelectAnswerForIndexPath:)]) {
        [_delegate tableViewCell:self didSelectAnswerForIndexPath:_indexPath];
    }
}

- (IBAction)likeButton_TUI:(UIButton *)sender {
    sender.selected = !sender.selected;
    _isLike = !_isLike;
    if (_isLike) {
        [self setLikesCount:_likesCount + 1];
    } else {
        [self setLikesCount:_likesCount - 1];
    }
    if ([_delegate respondsToSelector:@selector(tableViewCell:didSelectLike:forIndexPath:)]) {
        [_delegate tableViewCell:self didSelectLike:_isLike forIndexPath:_indexPath];
    }
}

@end

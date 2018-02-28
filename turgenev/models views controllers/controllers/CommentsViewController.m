//
//  CommentsViewController.m
//  turgenev
//
//  Created by Vladimir Psyukalov on 20.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "CommentsViewController.h"

#import "Macros.h"

#import "UIView+Custom.h"
#import "UILabel+Custom.h"
#import "UITextField+Custom.h"

#import "TableView.h"

#import "CommentTableViewCell.h"

#import "User.h"


#define kBottomDelta (8.f)


@interface CommentsViewController () <UITableViewDataSource, TableViewDelegate, CommentTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet TableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *editorView;
@property (weak, nonatomic) IBOutlet UIView *authorizationView;

@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorizationLabel;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightLC;

@property (weak, nonatomic) IBOutlet UIButton *deleteReceiverButton;

@property (strong, nonatomic) NSMutableArray<Comment *> *comments;

@property (strong, nonatomic) User *user;
@property (strong, nonatomic) User *receiver;

@end


@implementation CommentsViewController

#pragma mark - Overriding

- (instancetype)initWithImage:(UIImage *)image comments:(NSMutableArray<Comment *> *)comments {
    self = [super initWithImage:image];
    if (self) {
        _comments = comments;
        if (!_comments) {
            _comments = [NSMutableArray new];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self localize];
}

- (void)keyboardWillShow:(BOOL)show height:(CGFloat)height duration:(CGFloat)duration {
    [super keyboardWillShow:show height:height duration:duration];
    CGAffineTransform transform = show ? CGAffineTransformMakeTranslation(0.f, -height) : CGAffineTransformIdentity;
    _tableView.contentInset = show ? UIEdgeInsetsMake(0.f, 0.f, height + kBottomDelta, 0.f) : UIEdgeInsetsZero;
    [UIView animate:^{
        _editorView.transform = transform;
        _deleteReceiverButton.transform = transform;
    }
         completion:nil
           duration:duration];
}

- (void)didCloseButtonAction {
    [super didCloseButtonAction];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Custom accessors

- (void)setReceiver:(User *)receiver {
    _receiver = receiver;
    [_deleteReceiverButton setTitle:_receiver.name forState:UIControlStateNormal];
    _deleteReceiverButton.hidden = _receiver == nil;
}

#pragma mark - UITableViewDataSource, TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    _commentsLabel.hidden = _comments.count > 0;
    return _comments.count;
}

- (UITableViewCell *)tableView:(TableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIndex:0];
    Comment *comment = _comments[indexPath.row];
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.sender = comment.sender.name;
    cell.receiver = comment.receiver.name;
    cell.date = comment.stringDate;
    cell.comment = comment.text;
    cell.imageURL = comment.sender.imageURL;
    cell.likesCount = comment.likeIdentifiers.count;
    BOOL isLike = NO;
    for (NSNumber *identifier in comment.likeIdentifiers) {
        if ([identifier integerValue] == _user.identifier) {
            isLike = YES;
            break;
        }
    }
    cell.isLike = isLike;
    return cell;
}

#pragma mark - CommentTableViewCellDelegate

- (void)tableViewCell:(CommentTableViewCell *)tableViewCell didSelectLike:(BOOL)selected forIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)tableViewCell:(CommentTableViewCell *)tableViewCell didSelectAnswerForIndexPath:(NSIndexPath *)indexPath {
    [self setReceiver:_comments[indexPath.row].sender];
}

#pragma mark - Actions

- (void)authorizationView_TUI {
    // TODO:
    [UIView animate:^{
        _authorizationView.alpha = 0.f;
    }
         completion:nil];
}

- (IBAction)sendButton_TUI:(UIButton *)sender {
    if (_textField.text.length == 0) {
        return;
    }
    _user.name = @"Владимир";
    Comment *c = [Comment new];
    c.sender = _user;
    c.receiver = _receiver;
    [_comments addObject:c];
    [_tableView reloadData];
}

- (IBAction)deleteReceiver_TUI:(UIButton *)sender {
    [self setReceiver:nil];
}

#pragma mark - Other methods

- (void)setup {
    _user = [User shared];
    _tableView.refreshControl = nil;
    _tableView.alwaysBounceVertical = YES;
    [_tableView shadowWithOffset:CGSizeZero];
    [_tableView registerCellClass:[CommentTableViewCell class]];
    [_editorView shadowWithOffset:CGSizeZero];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(authorizationView_TUI)];
    [_authorizationView addGestureRecognizer:tapGR];
    CGFloat radius = _textField.frame.size.height / 2.f;
    [_textField cornerRadius:radius];
    [_textField borderWithColor:RGBA(198.f, 154.f, 128.f, 64.f)];
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, radius, 0.f)];
    [_deleteReceiverButton cornerRadius:_deleteReceiverButton.frame.size.height / 2.f];
    [_deleteReceiverButton shadowWithOffset:CGSizeZero];
    [self setReceiver:nil];
}

- (void)localize {
    [_tableView setTitle:LOCALIZE(@"cvc_title_0") withFont:[UIFont fontWithName:@"BN-Regular" size:22.f] andColor:RGB(198.f, 154.f, 128.f) insets:UIEdgeInsetsMake(22.f, 8.f, 32.f, 8.f)];
    _tableView.tableHeaderView.backgroundColor = [UIColor whiteColor];
    _commentsLabel.text = LOCALIZE(@"cvc_title_2");
    _authorizationLabel.text = LOCALIZE(@"cvc_title_3");
    [_authorizationLabel underline];
    _textField.placeholder = LOCALIZE(@"cvc_title_1");
    [_textField placeholderWithColor:RGB(128.f, 128.f, 128.f)];
}

@end

//
//  InfoCollectionViewCell.m
//  turgenev
//
//  Created by Vladimir Psyukalov on 19.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "InfoCollectionViewCell.h"

#import "UIView+Custom.h"


@interface InfoCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end


@implementation InfoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self shadowWithOffset:CGSizeZero];
}

- (void)setName:(NSString *)name {
    _name = name;
    _nameLabel.text = _name;
}

- (void)setAddress:(NSString *)address {
    _address = address;
    _addressLabel.text = _address;
}

@end

//
//  UILabel+Custom.m
//
//
//  Created by Vladimir Psyukalov on 19.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "UILabel+Custom.h"


@implementation UILabel (Custom)

- (void)attribute {
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.firstLineHeadIndent = 16.f;
    paragraphStyle.lineSpacing = 4.f;
    paragraphStyle.paragraphSpacing = 16.f;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    NSDictionary *attributes = @{NSParagraphStyleAttributeName : paragraphStyle,
                                 NSFontAttributeName : self.font,
                                 NSForegroundColorAttributeName : self.textColor};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self.text attributes:attributes];
    self.attributedText = attributedString;
}

- (void)underline {
    [self underlineWithRange:NSMakeRange(0, self.text.length)];
}

- (void)underlineWithRange:(NSRange)range {
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attributeString addAttribute:NSUnderlineStyleAttributeName value:@(1.f) range:range];
    self.attributedText = attributeString;
}

@end

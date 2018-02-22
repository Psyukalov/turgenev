//
//  Comment.m
//  turgenev
//
//  Created by Vladimir Psyukalov on 09.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "Comment.h"


#define kIdentifierKey (@"comment_identifier_key")
#define kDateKey (@"comment_date_key")
#define kStringDateKey (@"comment_string_date_key")
#define kTextKey (@"comment_text_key")
#define kLikeIdentifiersKey (@"comment_like_identifiers_key")
#define kDislikeIdentifiersKey (@"comment_dislike_identifiers_key")
#define kSenderKey (@"commet_sender_key")
#define kReceiverKey (@"comment_receiver_key")


@implementation Comment

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _identifier = [dictionary[@"identifier"] integerValue];
        _stringDate = dictionary[@"stringDate"];
        _text = dictionary[@"text"];
        _likeIdentifiers = dictionary[@"likeIdentifiers"];
        _dislikeIdentifiers = dictionary[@"dislikeIdentifiers"];
        _sender = [[User alloc] initWithDictionary:dictionary[@"sender"]];
        _receiver = [[User alloc] initWithDictionary:dictionary[@"receiver"]];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _identifier = [aDecoder decodeIntegerForKey:kIdentifierKey];
        _date = [aDecoder decodeObjectForKey:kDateKey];
        _stringDate = [aDecoder decodeObjectForKey:kStringDateKey];
        _text = [aDecoder decodeObjectForKey:kTextKey];
        _likeIdentifiers = [aDecoder decodeObjectForKey:kLikeIdentifiersKey];
        _dislikeIdentifiers = [aDecoder decodeObjectForKey:kDislikeIdentifiersKey];
        _sender = [aDecoder decodeObjectForKey:kSenderKey];
        _receiver = [aDecoder decodeObjectForKey:kReceiverKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:_identifier forKey:kIdentifierKey];
    [aCoder encodeObject:_date forKey:kDateKey];
    [aCoder encodeObject:_stringDate forKey:kStringDateKey];
    [aCoder encodeObject:_text forKey:kTextKey];
    [aCoder encodeObject:_likeIdentifiers forKey:kLikeIdentifiersKey];
    [aCoder encodeObject:_dislikeIdentifiers forKey:kDislikeIdentifiersKey];
    [aCoder encodeObject:_sender forKey:kSenderKey];
    [aCoder encodeObject:_receiver forKey:kReceiverKey];
}

- (NSDate *)date {
    if (!_date) {
        // TODO:
        _date = [NSDate new];
    }
    return _date;
}

@end

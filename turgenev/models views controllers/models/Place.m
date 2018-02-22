//
//  Place.m
//  turgenev
//
//  Created by Vladimir Psyukalov on 08.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "Place.h"


#define kIdentifierKey (@"place_identifier_key")
#define kTypeKey (@"place_type_key")
#define kLatitudeKey (@"place_latitude_key")
#define kLongitudeKey (@"place_longitude_key")
#define kRatingKey (@"place_rating_key")
#define kIsVisitedKey (@"place_is_visited_key")
#define kNameKey (@"place_name_key")
#define kAddressKey (@"place_address_key")
#define kPreviewTextKey (@"place_preview_text_key")
#define kMainTextKey (@"place_main_text_key")
#define kImageURLsKey (@"place_image_urls_key")
#define kCommentsKey (@"place_comments_key")
#define kMediaKey (@"place_media_key")
#define kDataKey (@"place_data_key")


@implementation Place

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _identifier = [dictionary[@"identifier"] integerValue];
        _type = [dictionary[@"type"] integerValue];
        _latitude = [dictionary[@"latitude"] floatValue];
        _longitude = [dictionary[@"longitude"] floatValue];
        _rating = [dictionary[@"rating"] floatValue];
        _isVisited = [dictionary[@"isVisited"] boolValue];
        _name = dictionary[@"name"];
        _address = dictionary[@"address"];
        _previewText = dictionary[@"previewText"];
        _mainText = dictionary[@"mainText"];
        _imageURLs = dictionary[@"imageURLs"];
        _comments = [NSMutableArray new];
        for (NSDictionary *commentDictionary in dictionary) {
            [_comments addObject:[[Comment alloc] initWithDictionary:commentDictionary]];
        }
        _media = dictionary[@"media"];
        _data = dictionary[@"data"];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _identifier = [aDecoder decodeIntegerForKey:kIdentifierKey];
        _type = [aDecoder decodeIntegerForKey:kTypeKey];
        _latitude = [aDecoder decodeDoubleForKey:kLatitudeKey];
        _longitude = [aDecoder decodeDoubleForKey:kLongitudeKey];
        _rating = [aDecoder decodeDoubleForKey:kRatingKey];
        _isVisited = [aDecoder decodeBoolForKey:kIsVisitedKey];
        _name = [aDecoder decodeObjectForKey:kNameKey];
        _address = [aDecoder decodeObjectForKey:kAddressKey];
        _previewText = [aDecoder decodeObjectForKey:kPreviewTextKey];
        _mainText = [aDecoder decodeObjectForKey:kMainTextKey];
        _imageURLs = [aDecoder decodeObjectForKey:kImageURLsKey];
        _comments = [aDecoder decodeObjectForKey:kCommentsKey];
        _media = [aDecoder decodeObjectForKey:kMediaKey];
        _data = [aDecoder decodeObjectForKey:kDataKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:_identifier forKey:kIdentifierKey];
    [aCoder encodeInteger:_type forKey:kTypeKey];
    [aCoder encodeDouble:_latitude forKey:kLatitudeKey];
    [aCoder encodeDouble:_longitude forKey:kLongitudeKey];
    [aCoder encodeDouble:_rating forKey:kRatingKey];
    [aCoder encodeBool:_isVisited forKey:kIsVisitedKey];
    [aCoder encodeObject:_name forKey:kNameKey];
    [aCoder encodeObject:_address forKey:kAddressKey];
    [aCoder encodeObject:_previewText forKey:kPreviewTextKey];
    [aCoder encodeObject:_mainText forKey:kMainTextKey];
    [aCoder encodeObject:_imageURLs forKey:kImageURLsKey];
    [aCoder encodeObject:_comments forKey:kCommentsKey];
    [aCoder encodeObject:_media forKey:kMediaKey];
    [aCoder encodeObject:_data forKey:kDataKey];
}

@end

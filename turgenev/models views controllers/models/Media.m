//
//  Media.m
//  turgenev
//
//  Created by Vladimir Psyukalov on 14.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "Media.h"


#define kLottieJSONKey (@"media_lottie_json_key")
#define kAudioKey (@"media_audio_key")


@implementation Media

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _lottieJSON = [aDecoder decodeObjectForKey:kLottieJSONKey];
        _audio = [aDecoder decodeObjectForKey:kAudioKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_lottieJSON forKey:kLottieJSONKey];
    [aCoder encodeObject:_audio forKey:kAudioKey];
}

@end

//
//  Settings.m
//  turgenev
//
//  Created by Vladimir Psyukalov on 06.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "Settings.h"


#define kNeededNotificationQuestsKey (@"settings_needed_notification_quests_key")
#define kNeededNotificationInterestingKey (@"settings_needed_notification_interesting_key")
#define kNeededNotificationPromotionsKey (@"settings_needed_notification_promotions_key")
#define kNeededNotificationEventsKey (@"settings_needed_notification_events_key")

#define kUserDefaultsSettingsKey (@"user_defaults_settings_key")


@implementation Settings

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _neededNotificationEvents = [dictionary[@"neededNotificationQuests"] boolValue];
        _neededNotificationInteresting = [dictionary[@"neededNotificationInteresting"] boolValue];
        _neededNotificationPromotions = [dictionary[@"neededNotificationPromotions"] boolValue];
        _neededNotificationEvents = [dictionary[@"neededNotificationEvents"] boolValue];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _neededNotificationQuests = [aDecoder decodeBoolForKey:kNeededNotificationQuestsKey];
        _neededNotificationInteresting = [aDecoder decodeBoolForKey:kNeededNotificationInterestingKey];
        _neededNotificationPromotions = [aDecoder decodeBoolForKey:kNeededNotificationPromotionsKey];
        _neededNotificationEvents = [aDecoder decodeBoolForKey:kNeededNotificationEventsKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeBool:_neededNotificationQuests forKey:kNeededNotificationQuestsKey];
    [aCoder encodeBool:_neededNotificationInteresting forKey:kNeededNotificationInterestingKey];
    [aCoder encodeBool:_neededNotificationPromotions forKey:kNeededNotificationPromotionsKey];
    [aCoder encodeBool:_neededNotificationEvents forKey:kNeededNotificationEventsKey];
}

- (void)save {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:data forKey:kUserDefaultsSettingsKey];
    [userDefaults synchronize];
}

- (void)load {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:kUserDefaultsSettingsKey];
    Settings *settings = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (settings) {
        _neededNotificationQuests = settings.neededNotificationQuests;
        _neededNotificationInteresting = settings.neededNotificationInteresting;
        _neededNotificationPromotions = settings.neededNotificationPromotions;
        _neededNotificationEvents = settings.neededNotificationEvents;
    }
}

@end

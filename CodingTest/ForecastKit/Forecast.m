//
//  Forecast.m
//  CodingTest
//
//  Created by Joseph Lee on 13/11/15.
//  Copyright © 2015 Joseph Lee. All rights reserved.
//

#import "Forecast.h"

@implementation Forecast

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"longitude" : @"longitude",
             @"latitude" : @"latitude",
             @"timezone" : @"timezone",
             @"offset" : @"offset",
             @"currently" : @"currently",
             @"minutely" : @"minutely",
             @"hourly" : @"hourly",
             @"daily" : @"daily",
             @"alerts" : @"alerts",
             @"flags" : @"flags"
             };
}

+ (NSValueTransformer *)currentlyJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:ForecastCurrently.class];
}

+ (NSValueTransformer *)minutelyJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:ForecastMinutely.class];
}

+ (NSValueTransformer *)hourlyJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:ForecastHourly.class];
}

+ (NSValueTransformer *)dailyJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:ForecastDaily.class];
}

+ (NSValueTransformer *)alertsTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:ForecastAlert.class];
}

+ (NSValueTransformer *)flagsJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:ForecastFlags.class];
}

@end

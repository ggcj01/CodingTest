//
//  ForecastAlerts.m
//  CodingTest
//
//  Created by Joseph Lee on 13/11/15.
//  Copyright © 2015 Joseph Lee. All rights reserved.
//

#import "ForecastAlert.h"

@implementation ForecastAlert

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"title" : @"title",
             @"time" : @"time",
             @"expires" : @"expires",
             @"alert_description" : @"description",
             @"uri" : @"uri"
             };
}

@end

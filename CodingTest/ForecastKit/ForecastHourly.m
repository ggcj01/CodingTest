//
//  ForecastHourly.m
//  CodingTest
//
//  Created by Joseph Lee on 13/11/15.
//  Copyright © 2015 Joseph Lee. All rights reserved.
//

#import "ForecastHourly.h"
#import "ForecastData.h"

@implementation ForecastHourly

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"summary" : @"summary",
             @"icon" : @"icon",
             @"data" : @"data"
             };
}

+ (NSValueTransformer *)dataTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:ForecastData.class];
}

@end

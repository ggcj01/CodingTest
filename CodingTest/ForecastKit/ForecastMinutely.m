//
//  ForecastMinutely.m
//  CodingTest
//
//  Created by Joseph Lee on 13/11/15.
//  Copyright © 2015 Joseph Lee. All rights reserved.
//

#import "ForecastMinutely.h"
#import "ForecastData.h"

@implementation ForecastMinutely

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

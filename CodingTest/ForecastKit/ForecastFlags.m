//
//  ForecastFlags.m
//  CodingTest
//
//  Created by Joseph Lee on 13/11/15.
//  Copyright © 2015 Joseph Lee. All rights reserved.
//

#import "ForecastFlags.h"

@implementation ForecastFlags

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"darksky_stations" : @"darksky-stations",
             @"datapoint_stations" : @"datapoint-stations",
             @"isd_stations" : @"isd-stations",
             @"lamp_stations" : @"lamp-stations",
             @"metar_stations" : @"metar-stations",
             @"units" : @"units"
             };
}

+ (NSValueTransformer *)darksky_stationsTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:NSString.class];
}

+ (NSValueTransformer *)datapoint_stationsTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:NSString.class];
}

+ (NSValueTransformer *)isd_stationsTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:NSString.class];
}

+ (NSValueTransformer *)lamp_stationsTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:NSString.class];
}

+ (NSValueTransformer *)metar_stationsTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:NSString.class];
}


@end

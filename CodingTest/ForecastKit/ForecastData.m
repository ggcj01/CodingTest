//
//  ForecastData.m
//  CodingTest
//
//  Created by Joseph Lee on 13/11/15.
//  Copyright © 2015 Joseph Lee. All rights reserved.
//

#import "ForecastData.h"

@implementation ForecastData

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"time" : @"time",
             @"summary" : @"summary",
             @"icon" : @"icon",
             @"sunriseTime" : @"sunriseTime",
             @"sunsetTime" : @"sunsetTime",
             @"moonPhase" : @"moonPhase",
             @"nearestStormDistance" : @"nearestStormDistance",
             @"nearestStormBearing" : @"nearestStormBearing",
             @"precipIntensity" : @"precipIntensity",
             @"precipIntensityMax" : @"precipIntensityMax",
             @"precipIntensityMaxTime" : @"precipIntensityMaxTime",
             @"precipProbability" : @"precipProbability",
             @"precipType" : @"precipType",
             @"precipAccumulation" : @"precipAccumulation",
             @"temperature" : @"temperature",
             @"temperatureMin" : @"temperatureMin",
             @"temperatureMinTime" : @"temperatureMinTime",
             @"temperatureMax" : @"temperatureMax",
             @"temperatureMaxTime" : @"temperatureMaxTime",
             @"apparentTemperature" : @"apparentTemperature",
             @"apparentTemperatureMin" : @"apparentTemperatureMin",
             @"apparentTemperatureMinTime" : @"apparentTemperatureMinTime",
             @"apparentTemperatureMax" : @"apparentTemperatureMax",
             @"apparentTemperatureMaxTime" : @"apparentTemperatureMaxTime",
             @"dewPoint" : @"dewPoint",
             @"humidity" : @"humidity",
             @"windSpeed" : @"windSpeed",
             @"windBearing" : @"windBearing",
             @"visibility" : @"visibility",
             @"cloudCover" : @"cloudCover",
             @"pressure" : @"pressure",
             @"ozone" : @"ozone"
             };
}

@end

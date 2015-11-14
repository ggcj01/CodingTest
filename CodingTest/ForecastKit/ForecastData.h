//
//  ForecastData.h
//  CodingTest
//
//  Created by Joseph Lee on 13/11/15.
//  Copyright © 2015 Joseph Lee. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ForecastData : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSNumber *time;
@property (nonatomic, copy, readonly) NSString *summary;
@property (nonatomic, copy, readonly) NSString *icon;

@property (nonatomic, copy, readonly) NSNumber *sunriseTime;
@property (nonatomic, copy, readonly) NSNumber *sunsetTime;
@property (nonatomic, copy, readonly) NSNumber *moonPhase;

@property (nonatomic, copy, readonly) NSNumber *nearestStormDistance;
@property (nonatomic, copy, readonly) NSNumber *nearestStormBearing;

@property (nonatomic, copy, readonly) NSNumber *precipIntensity;
@property (nonatomic, copy, readonly) NSNumber *precipIntensityMax;
@property (nonatomic, copy, readonly) NSNumber *precipIntensityMaxTime;

@property (nonatomic, copy, readonly) NSNumber *precipProbability;
@property (nonatomic, copy, readonly) NSString *precipType;
@property (nonatomic, copy, readonly) NSNumber *precipAccumulation;

@property (nonatomic, copy, readonly) NSNumber *temperature;
@property (nonatomic, copy, readonly) NSNumber *temperatureMin;
@property (nonatomic, copy, readonly) NSNumber *temperatureMinTime;
@property (nonatomic, copy, readonly) NSNumber *temperatureMax;
@property (nonatomic, copy, readonly) NSNumber *temperatureMaxTime;

@property (nonatomic, copy, readonly) NSNumber *apparentTemperature;
@property (nonatomic, copy, readonly) NSNumber *apparentTemperatureMin;
@property (nonatomic, copy, readonly) NSNumber *apparentTemperatureMinTime;
@property (nonatomic, copy, readonly) NSNumber *apparentTemperatureMax;
@property (nonatomic, copy, readonly) NSNumber *apparentTemperatureMaxTime;

@property (nonatomic, copy, readonly) NSNumber *dewPoint;
@property (nonatomic, copy, readonly) NSNumber *humidity;
@property (nonatomic, copy, readonly) NSNumber *windSpeed;
@property (nonatomic, copy, readonly) NSNumber *windBearing;
@property (nonatomic, copy, readonly) NSNumber *visibility;
@property (nonatomic, copy, readonly) NSNumber *cloudCover;
@property (nonatomic, copy, readonly) NSNumber *pressure;
@property (nonatomic, copy, readonly) NSNumber *ozone;

@end

//
//  Forecast.h
//  CodingTest
//
//  Created by Joseph Lee on 13/11/15.
//  Copyright © 2015 Joseph Lee. All rights reserved.
//

#import <Mantle/Mantle.h>

#import "ForecastAlert.h"
#import "ForecastCurrently.h"
#import "ForecastDaily.h"
#import "ForecastFlags.h"
#import "ForecastHourly.h"
#import "ForecastMinutely.h"

/*!
 * @see Forecast API documentation at : https://developer.forecast.io/docs/v2
 */
@interface Forecast : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSNumber *latitude;
@property (nonatomic, copy, readonly) NSNumber *longitude;
@property (nonatomic, copy, readonly) NSString *timezone;
@property (nonatomic, copy, readonly) NSNumber *offset;
@property (nonatomic, strong, readonly) ForecastCurrently *currently;
@property (nonatomic, strong, readonly) ForecastMinutely *minutely;
@property (nonatomic, strong, readonly) ForecastHourly *hourly;
@property (nonatomic, strong, readonly) ForecastDaily *daily;
@property (nonatomic, copy, readonly) NSArray *alerts;
@property (nonatomic, strong, readonly) ForecastFlags *flags;

@end

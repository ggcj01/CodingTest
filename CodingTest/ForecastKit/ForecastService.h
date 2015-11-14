//
//  ForecastService.h
//  CodingTest
//
//  Created by Joseph Lee on 13/11/15.
//  Copyright © 2015 Joseph Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Forecast.h"

@interface ForecastService : NSObject

/**
 * @brief Initializes and returns a new ForecastService object
 * @param key string value from Forecast API
 * @see Forecast API documentation at : https://developer.forecast.io/docs/v2
 * @return ForecastService object
 */
-(id)initWithAPIKey:(NSString*)key;

/**
 * @param Request forecast for location
 * @see Forecast API documentation at : https://developer.forecast.io/docs/v2
 * @returns Forecast object data
 */
-(void)getForecastForLatitude:(double)latitude
                    longitude:(double)longitude
                      success:(void (^)(Forecast *forecast))success
                      failure:(void (^)(NSError *error))failure;

@end

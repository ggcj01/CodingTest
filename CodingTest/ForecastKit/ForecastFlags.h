//
//  ForecastFlags.h
//  CodingTest
//
//  Created by Joseph Lee on 13/11/15.
//  Copyright © 2015 Joseph Lee. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ForecastFlags : MTLModel <MTLJSONSerializing>

//@property (nonatomic, copy, readonly) id darksky_unavailable; // cannot find information on property type return data
//@property (nonatomic, copy, readonly) id *metno-license; // cannot find information on property type return data

@property (nonatomic, copy, readonly) NSArray *darksky_stations;
@property (nonatomic, copy, readonly) NSArray *datapoint_stations;
@property (nonatomic, copy, readonly) NSArray *isd_stations;
@property (nonatomic, copy, readonly) NSArray *lamp_stations;
@property (nonatomic, copy, readonly) NSArray *metar_stations;
@property (nonatomic, copy, readonly) NSString *units;

@end

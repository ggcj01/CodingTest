//
//  ForecastAlerts.h
//  CodingTest
//
//  Created by Joseph Lee on 13/11/15.
//  Copyright © 2015 Joseph Lee. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ForecastAlert : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *time;
@property (nonatomic, copy, readonly) NSNumber *expires;
@property (nonatomic, copy, readonly) NSString *alert_description;
@property (nonatomic, copy, readonly) NSString *uri;

@end

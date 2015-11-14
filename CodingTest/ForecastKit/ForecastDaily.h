//
//  ForecastDaily.h
//  CodingTest
//
//  Created by Joseph Lee on 13/11/15.
//  Copyright © 2015 Joseph Lee. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ForecastDaily : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *summary;
@property (nonatomic, copy, readonly) NSString *icon;
@property (nonatomic, copy, readonly) NSArray *data;

@end

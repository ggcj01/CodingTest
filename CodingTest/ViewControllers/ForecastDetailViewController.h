//
//  ForecastDetailViewController.h
//  CodingTest
//
//  Created by Joseph Lee on 13/11/15.
//  Copyright © 2015 Joseph Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Forecast;

@interface ForecastDetailViewController : UIViewController

/*
 * Popover view used when map annotation has been selected
 */
- (instancetype)initWithForecast:(Forecast *)forecast;

@end

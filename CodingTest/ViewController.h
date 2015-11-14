//
//  ViewController.h
//  CodingTest
//
//  Created by Joseph Lee on 13/11/15.
//  Copyright © 2015 Joseph Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ForecastMapView.h"

@interface ViewController : UIViewController <ForecastMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *forecastMapViewContainer;

@end


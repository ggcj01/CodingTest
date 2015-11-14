//
//  ViewController.m
//  CodingTest
//
//  Created by Joseph Lee on 13/11/15.
//  Copyright © 2015 Joseph Lee. All rights reserved.
//

#import "ViewController.h"
#import "ForecastMapView.h"
#import "ForecastDetailViewController.h"
#import "MBProgressHUD.h"

@interface ViewController () {
    ForecastMapView *forecastMapView;
    MBProgressHUD *hud;
}
@end

@implementation ViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Add forecast map view to view controller
    forecastMapView = [[ForecastMapView alloc] init];
    forecastMapView.forecastDelegate = self;
    [self.view addSubview:forecastMapView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // Set correct frame position for forecast map view
    [forecastMapView setFrame:self.forecastMapViewContainer.frame];
}

#pragma mark - IBAction Events

- (IBAction)refreshUserLocationPressed:(id)sender {
    
    // Get forecast
    [forecastMapView getForecast];
}

#pragma mark - Forecast Mapview Delegate

- (void)forecastGPSRequestDidStart {
    [hud hide:YES]; // Hide if already showing
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Retrieving gps...";
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = NO;
    hud.removeFromSuperViewOnHide = YES;
    hud.yOffset = self.forecastMapViewContainer.center.y - 80;
}

- (void)forecastGPSRequestDidFinish:(NSError *)error {
    if (!error) {
        // Do nothing
    }
    else {
        hud.labelText = @"Error retrieving current location!!!";
        [hud hide:YES afterDelay:1.5f];
    }
}

- (void)forecastRequestDidStart {
    hud.labelText = @"Retrieving weather...";
}

- (void)forecastRequestDidFinish:(NSError *)error {
    if (!error) {
        hud.labelText = @"Finished retrieving weather...";
    }
    else {
        hud.labelText = @"Error retrieving weather!!!";
    }
    [hud hide:YES afterDelay:1.5f];
}

/* // Enable Forecast Delegate methods for customization
- (MKAnnotationView *)forecastMapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    return nil;
}

- (void)forecastMapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
}

- (void)forecastMapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    
}
 */

@end

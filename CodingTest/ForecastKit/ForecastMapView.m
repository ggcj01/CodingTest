//
//  ForecastMapView.m
//  CodingTest
//
//  Created by Joseph Lee on 14/11/15.
//  Copyright © 2015 Joseph Lee. All rights reserved.
//

#import "ForecastMapView.h"
#import "Forecast.h"
#import "ForecastService.h"
#import "ForecastDetailViewController.h"

@implementation ForecastMapView  {
    
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    
    BOOL achievedDesiredAccuracy; // Used to determine when gps accuracy has been loaded
}

- (instancetype)init {
    if (self = [super init]) {
        
        self.delegate = self; // Assign map delegate to self
        self.showsUserLocation = NO;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleBottomMargin ;
        
        self.currentForecast = nil;
        [self removeMapAnnotations];
        
        currentLocation = nil;
        achievedDesiredAccuracy = NO;
        
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // Set an accuracy level
        
        // Check if iOS8 compatible
        if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [locationManager requestWhenInUseAuthorization];
        }
        [locationManager startUpdatingLocation];
    }
    return self;
}

// Attempt to get forcast using gps location
- (void)getForecast
{
    // Reset class variables and map annotations
    [self removeMapAnnotations];

    self.currentForecast = nil;
    achievedDesiredAccuracy = NO;
    
    // Get current user location
    [locationManager startUpdatingLocation];
    
    // Notify status of gps request
    [self gpsRequestDidStart];
}

#pragma mark - Location services

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([error domain] == kCLErrorDomain) {
        switch ([error code]) {
            case kCLErrorLocationUnknown: { // location is currently unknown, but CL will keep trying
                break;
            }
            default: {
                /*
                 kCLErrorDenied                                 // Access to location or ranging has been denied by the user
                 kCLErrorNetwork                                // general, network-related error
                 kCLErrorHeadingFailure,                        // heading could not be determined
                 kCLErrorRegionMonitoringDenied,                // Location region monitoring has been denied by the user
                 kCLErrorRegionMonitoringFailure,               // A registered region cannot be monitored
                 kCLErrorRegionMonitoringSetupDelayed,          // CL could not immediately initialize region monitoring
                 kCLErrorRegionMonitoringResponseDelayed,       // While events for this fence will be delivered, delivery will not occur immediately
                 kCLErrorGeocodeFoundNoResult,                  // A geocode request yielded no result
                 kCLErrorGeocodeFoundPartialResult,             // A geocode request yielded a partial result
                 kCLErrorGeocodeCanceled,                       // A geocode request was cancelled
                 kCLErrorDeferredFailed,                        // Deferred mode failed
                 kCLErrorDeferredNotUpdatingLocation,           // Deferred mode failed because location updates disabled or paused
                 kCLErrorDeferredAccuracyTooLow,                // Deferred mode not supported for the requested accuracy
                 kCLErrorDeferredDistanceFiltered,              // Deferred mode does not support distance filters
                 kCLErrorDeferredCanceled,                      // Deferred mode request canceled a previous request
                 kCLErrorRangingUnavailable,                    // Ranging cannot be performed
                 kCLErrorRangingFailure,                        // General ranging failure
                 */

                // Stop trying to get gps if there is an error
                [locationManager stopUpdatingLocation];
                
                // Notify gps error
                [self gpsDidReceiveError:error];
                
                break;
            }
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // Don't do anything if desired accuracy has already been reached
    if (achievedDesiredAccuracy)
        return;
    
    if (locations.count > 0) {
        currentLocation = [locations lastObject];
    }
    
    // Check for accuracy of the returned data. If the timestamp of the location is out by 5 seconds,
    // we can assume that it is an old location and shouldn't be used.
    NSTimeInterval locationAge = -[currentLocation.timestamp timeIntervalSinceNow];
    
    if (locationAge > 5.0) {
        return;
    }
    
    // Check to see if valid accuracy and is below desired accuracy
    if (currentLocation.horizontalAccuracy >= 0 && currentLocation.horizontalAccuracy <= locationManager.desiredAccuracy ) {
        
        // Stop location services as desired accuracy has been achieved
        [locationManager stopUpdatingLocation];
        
        achievedDesiredAccuracy = YES;
        
        // Zoom to user location within 2500m view area
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 2500, 2500);
        [self setRegion:region animated:YES];
        
        // Achieved desired gps location, get weather forcast
        [self getForecastForLatitude:currentLocation.coordinate.latitude longitude:currentLocation.coordinate.longitude];
    }
}

// Method used to stop gps locater if gps cannot be located within timeout period
- (void)gpsDidReceiveError:(NSError *)error {
    
    NSLog(@"error");

    if (!achievedDesiredAccuracy) {
        NSLog(@"daf");
        [locationManager stopUpdatingLocation];
        
        if (error) {
            [self gpsRequestDidFinish:error];
        }
        else {
            // Create error event for timeout
            NSError *error = [NSError errorWithDomain:@"com.codetesting" code:-1 userInfo:nil];
            [self gpsRequestDidFinish:error];
        }
    }
}

#pragma mark - MapView Methods

- (void)addWeatherAnnotationAtUserLocation {
    // Adds annotation at user location
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = currentLocation.coordinate;
    [self addAnnotation:annotation];
}

- (void)removeMapAnnotations {
    // Remove all annotations on map
    [self removeAnnotations:self.annotations];
}

#pragma mark - MapView Delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        // Try to dequeue an existing pin view first.
        static NSString *identifer = @"AnnotationIdentifer";
        MKAnnotationView *pinView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identifer];
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifer];
            
            // Get weather icon from bundle
            NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"ForecastImages" ofType:@"bundle"];
            NSString *imageName = [[NSBundle bundleWithPath:bundlePath] pathForResource:self.currentForecast.currently.icon ofType:@"png"];
            UIImage *icon = [[UIImage alloc] initWithContentsOfFile:imageName];
            
            pinView.image = icon;
            pinView.frame = CGRectMake(0, 0, 96, 96);
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    if ([self.forecastDelegate respondsToSelector:@selector(forecastMapView:didSelectAnnotationView:)]) {
        [self.forecastDelegate forecastMapView:mapView didSelectAnnotationView:view];
    }
    else {
        if (self.forecastDelegate != nil && [self.forecastDelegate respondsToSelector:@selector(presentViewController:animated:completion:)]) {
            
            // Deselect annotation can it can be clicked again
            [mapView deselectAnnotation:view.annotation animated:NO];

            ForecastDetailViewController *forecastDetailVC = [[ForecastDetailViewController alloc] initWithForecast:self.currentForecast];
            
            forecastDetailVC.popoverPresentationController.sourceView = mapView;
            forecastDetailVC.popoverPresentationController.sourceRect = view.frame;
            
            [self.forecastDelegate presentViewController:forecastDetailVC animated:YES completion:nil];
        }
        else {
            // Do nothing
        }
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    
    if ([self.forecastDelegate respondsToSelector:@selector(forecastMapView:didDeselectAnnotationView:)]) {
        [self.forecastDelegate forecastMapView:mapView didDeselectAnnotationView:view];
    }
    else {
        // Do nothing
    }
}

#pragma mark - Forecast request progress

// GPS request started
- (void)gpsRequestDidStart {    
    if ([self.forecastDelegate respondsToSelector:@selector(forecastGPSRequestDidStart)]) {
        [self.forecastDelegate forecastGPSRequestDidStart];
    }
}

// GPS request finished
- (void)gpsRequestDidFinish:(NSError *)error {
    if ([self.forecastDelegate respondsToSelector:@selector(forecastGPSRequestDidFinish:)]) {
        [self.forecastDelegate forecastGPSRequestDidFinish:error];
    }
}

// API service started
- (void)forecastRequestDidStart {
    if ([self.forecastDelegate respondsToSelector:@selector(forecastRequestDidStart)]) {
        [self.forecastDelegate forecastRequestDidStart];
    }
}

// API service finished
- (void)forecastRequestDidFinish:(NSError *)error {
    if ([self.forecastDelegate respondsToSelector:@selector(forecastRequestDidFinish:)]) {
        [self.forecastDelegate forecastRequestDidFinish:error];
    }
}

#pragma mark - API services

- (void)getForecastForLatitude:(double)latitude longitude:(double)longitude {
    
    __weak typeof(self) weakSelf = self;

    // Send start signal
    [weakSelf forecastRequestDidStart];

    // Initiate service to get forecast
    ForecastService *forecastService = [[ForecastService alloc] initWithAPIKey:@"052bdd5cb7a903aa6e9c76efc23b9c6c"];
    [forecastService getForecastForLatitude:latitude longitude:longitude success:^(Forecast *forecast) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            
            // Assign current forecast
            strongSelf.currentForecast = forecast;
            
            // Get annotation of user location
            [strongSelf addWeatherAnnotationAtUserLocation];
            
            // Send finish signal
            [strongSelf forecastRequestDidFinish:nil];
        }
        
    } failure:^(NSError *error) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            // Send finish signal
            [strongSelf forecastRequestDidFinish:error];
        }
    }];
}


@end

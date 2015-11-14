//
//  ForecastMapView.h
//  CodingTest
//
//  Created by Joseph Lee on 14/11/15.
//  Copyright © 2015 Joseph Lee. All rights reserved.
//

#import <MapKit/MapKit.h>

@import MapKit;
@import CoreLocation;

@class Forecast;

// Forecast delegate methods
@protocol ForecastMapViewDelegate <NSObject>

@optional

/**
 * @brief Get user location
 */
- (void)forecastGPSRequestDidStart;

/**
 * @brief GPS request finished
 * @discussion Error will be returned if there is timeout or other gps location service errors
 * @return error will be nil if successful, or with error object
 */
- (void)forecastGPSRequestDidFinish:(NSError *)error;

/**
 * @brief Get forecast API service initated
 * @discussion Should show some sort of loading spinner for user
 */
- (void)forecastRequestDidStart;

/**
 * @brief Get forecast API service finished
 * @discussion Should update the user interface to indicate API service call has finished
 * @return error will be nil if successful, or with error object
 */
- (void)forecastRequestDidFinish:(NSError *)error;


/**
 * @brief MapView delegate methods
 * @discussion For customization of mapview annotations
 */
- (MKAnnotationView *)forecastMapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation;

/**
 * @brief MapView delegate methods
 * @discussion For customization of mapview did select annotation
 */
- (void)forecastMapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view;

/**
 * @brief MapView delegate methods
 * @discussion For customization of mapview did deselect annotation
 */
- (void)forecastMapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view;

@end

@interface ForecastMapView : MKMapView <MKMapViewDelegate, CLLocationManagerDelegate, UIPopoverPresentationControllerDelegate>

/**
 * Delegate for handling forecast protocol
 * @see ForecastMapViewDelegate
 */
@property (weak, nonatomic) UIViewController <ForecastMapViewDelegate> *forecastDelegate;

// Current forecast used for displaying map annotations
@property (strong, nonatomic) Forecast *currentForecast;

/**
 * @brief Get forcast for current user location
 * @discussion Implement forecastRequestDidStart and forecastRequestDidFinish:error for aysn state
 */
- (void)getForecast;

@end

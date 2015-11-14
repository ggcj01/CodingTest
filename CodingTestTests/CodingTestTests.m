//
//  CodingTestTests.m
//  CodingTestTests
//
//  Created by Joseph Lee on 13/11/15.
//  Copyright © 2015 Joseph Lee. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "ForecastService.h"

@interface CodingTestTests : XCTestCase {
    NSString *key;
    double sydneyLatitude;
    double sydneyLongitude;
}

@end

@implementation CodingTestTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    key = @"052bdd5cb7a903aa6e9c76efc23b9c6c";
    
    sydneyLatitude = 33.8650;
    sydneyLongitude = 151.2094;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSydneyForecast {
    XCTestExpectation *expectation = [self expectationWithDescription:@"High Expectation"];
    
    ForecastService *forecastService = [[ForecastService alloc] initWithAPIKey:key];
    
    [forecastService getForecastForLatitude:sydneyLatitude longitude:sydneyLongitude success:^(id forecast) {
        XCTAssertNotNil(forecast, @"Response is nil");
        XCTAssertTrue([forecast isKindOfClass:Forecast.class], @"");
        
        [expectation fulfill];
    } failure:^(NSError *error) {
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError * _Nullable error) {
        if (error) {
            XCTFail(@"Timeout error: %@", error);
        }
    }];
}

- (void)testInvalidAPIKey {
    XCTestExpectation *expectation = [self expectationWithDescription:@"High Expectation"];
    
    ForecastService *forecastService = [[ForecastService alloc] initWithAPIKey:@"1234567890abcdefg"];
    [forecastService getForecastForLatitude:sydneyLatitude longitude:sydneyLongitude success:^(Forecast *forecast) {
        XCTFail(@"Should fail because of invalid key!");
        [expectation fulfill];
    } failure:^(NSError *error) {
        XCTAssertNotNil(error, @"Error should not be nil!");
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError * _Nullable error) {
        if (error) {
            XCTFail(@"Timeout error: %@", error);
        }
    }];
}

- (void)testForecastServicePerformance {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.

    }];
}

@end

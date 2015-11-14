//
//  ForecastService.m
//  CodingTest
//
//  Created by Joseph Lee on 13/11/15.
//  Copyright © 2015 Joseph Lee. All rights reserved.
//

#import "ForecastService.h"

#import "AFNetworking.h"

@interface ForecastService()

@property (nonatomic, strong) NSString *apiKey;

@end

NSString *const baseURL = @"https://api.forecast.io/forecast";

@implementation ForecastService

-(id)initWithAPIKey:(NSString*)key {
    self = [super init];
    if (self = [super init]) {
        self.apiKey = [key copy];
    }
    return self;
}

-(void)getForecastForLatitude:(double)latitude
                    longitude:(double)longitude
                      success:(void (^)(Forecast *forecast))success
                      failure:(void (^)(NSError *error))failure {
    
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%f,%f", baseURL, self.apiKey, latitude, longitude];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSError *error = nil;
        Forecast *fc = [MTLJSONAdapter modelOfClass:Forecast.class fromJSONDictionary:responseObject error:&error];
        
        if (!error) {
            success(fc);
        }
        else {
            NSLog(@"Error: %@", error);
            failure(error);
        }
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        failure(error);
    }];
}

@end

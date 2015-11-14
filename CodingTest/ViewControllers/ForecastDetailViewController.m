//
//  ForecastDetailViewController.m
//  CodingTest
//
//  Created by Joseph Lee on 13/11/15.
//  Copyright © 2015 Joseph Lee. All rights reserved.
//

#import "ForecastDetailViewController.h"

#import "Forecast.h"
#import "Mantle.h"

@interface ForecastDetailViewController () <UIPopoverPresentationControllerDelegate>

@property (copy, nonatomic) Forecast *forecast;
@property (strong, nonatomic) UITextView *forecastTextView;

@end

@implementation ForecastDetailViewController

#pragma mark - View Lifecycle

- (instancetype)init
{
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationPopover;
        self.popoverPresentationController.delegate = self;
    }
    
    return self;
}

- (instancetype)initWithForecast:(Forecast *)forecast {
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationPopover;
        self.popoverPresentationController.delegate = self;
        self.forecast = forecast;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setForecastTextView];
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone; // Enabled popover for iPhone
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Forecast formatter

- (void)setForecastTextView {

    self.forecastTextView = [[UITextView alloc] initWithFrame:self.view.frame];
    self.forecastTextView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    self.forecastTextView.editable = NO;
    [self.view addSubview:self.forecastTextView];

    if (self.forecast != nil) {
        NSError *error = nil;
        NSDictionary *JSONDictionary = [MTLJSONAdapter JSONDictionaryFromModel:self.forecast error:&error];
        
        if (!error) {
            [self.forecastTextView setText:[NSString stringWithFormat:@"%@", JSONDictionary]];
        }
        else {
            [self.forecastTextView setText:[NSString stringWithFormat:@"%@", error.localizedDescription]];
        }
    }
}

@end

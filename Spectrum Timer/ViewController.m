//
//  ViewController.m
//  Spectrum Timer
//
//  Created by Rich Humphrey on 3/21/14.
//  Copyright (c) 2014 Rich Humphrey. All rights reserved.
//

#import "ViewController.h"
#import "CountdownViewController.h"
#define kTimerSetting @"timerSetting"

@implementation ViewController

- (void)viewWillLayoutSubviews
{
    
    [super viewWillLayoutSubviews];
    
    // persist the start time from previous launches or set it to 1 minute
    // set the user defaults to their default values
    NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
    
    if (![defaults integerForKey:kTimerSetting]) {
        
        // if the defaults are not set, set them here
        // initialize the timer to 60 seconds
        [defaults setInteger:120 forKey:kTimerSetting];
        [defaults synchronize];
        
    }
    
    
    double numSeconds = [defaults integerForKey:kTimerSetting];
    NSTimeInterval timerValue = numSeconds;
    
    // take the value and populate the text field
    
    timerField.text = [self getTimeFromInterval:timerValue];
    
    _countdownTimePicker.countDownDuration = timerValue;
    
    timerField.inputView = _countdownTimePicker;
   
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
}



- (void) viewDidAppear:(BOOL)animated {
    
    //[self.view setBackgroundColor:[UIColor whiteColor]];
    
    if (!self.previousTimerLeft) {
        
        //NSLog(@"remove the resume button");
        [self.navigationItem setRightBarButtonItem:nil];
        
    } else {
        
        [self.navigationItem setRightBarButtonItem:resumeButton];
        
    }
    
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"StartTimer"]) {
        
        CountdownViewController *countdownController = segue.destinationViewController;
        countdownController.timerSeconds = _countdownTimePicker.countDownDuration;
        countdownController.parentController = self;
        
    }
    
    
    if ([[segue identifier] isEqualToString:@"ResumeTimer"]) {
        
        CountdownViewController *countdownController = segue.destinationViewController;
        countdownController.timerSeconds = self.previousTimerLeft;
        countdownController.parentController = self;
    }
    
}

/*
- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskPortrait;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}
*/ 

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


-(BOOL)prefersStatusBarHidden
{
    return YES;
}


- (IBAction)setCountdown:(id)sender {
    
    // take the value and populate the text field
    
    NSTimeInterval seconds = _countdownTimePicker.countDownDuration;
    
    timerField.text = [self getTimeFromInterval:seconds];
    
    // persist the time here??
    
    NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
    
    [defaults setInteger:seconds forKey:kTimerSetting];
    [defaults synchronize];
        
    
    
}


- (NSString *)getTimeFromInterval:(NSTimeInterval)interval {
    
    // take the value and populate the text field
    
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:interval];
    
    // Create a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if (interval >= 3600) {
        
        [dateFormatter setDateFormat:@"hh:mm:ss"];
        
    } else {
        
        [dateFormatter setDateFormat:@"mm:ss"];
        
    }
    
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    // Format the elapsed time and set it to the label
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    
    return (timeString);
    
    
}










@end

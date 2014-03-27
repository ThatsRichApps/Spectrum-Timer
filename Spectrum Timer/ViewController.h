//
//  ViewController.h
//  Spectrum Timer
//

//  Copyright (c) 2014 Rich Humphrey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    
    IBOutlet UITextField *timerField;
    IBOutlet UIBarButtonItem *resumeButton;

}

@property (weak, nonatomic) IBOutlet UIDatePicker *countdownTimePicker;
@property (nonatomic, assign) NSTimeInterval previousTimerLeft;

- (IBAction)setCountdown:(id)sender;

@end

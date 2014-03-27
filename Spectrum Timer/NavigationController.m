//
//  NavigationController.m
//  Spectrum Timer
//
//  Created by Rich Humphrey on 3/24/14.
//  Copyright (c) 2014 Rich Humphrey. All rights reserved.
//

#import "NavigationController.h"
#import "CountdownViewController.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    //[self.view setBackgroundColor:[UIColor whiteColor]];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (BOOL)shouldAutorotate
{
    
    //if ([self.topViewController isKindOfClass:[CountdownViewController class]])
    //    return YES;
    
    return YES;

}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {

        return UIInterfaceOrientationMaskPortrait;
    
    } else {

        // just for the ipad version allow the timer countdown screen to rotate...
        
        if ([self.topViewController isKindOfClass:[CountdownViewController class]])
            return UIInterfaceOrientationMaskAll;
        
        return UIInterfaceOrientationMaskLandscape;
    
    }

}





@end

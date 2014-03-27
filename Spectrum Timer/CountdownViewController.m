//
//  CountdownViewController.m
//  Spectrum Timer
//
//  Created by Rich Humphrey on 3/21/14.
//  Copyright (c) 2014 Rich Humphrey. All rights reserved.
//

#import "CountdownViewController.h"
#import "MainTimerScene.h"

@interface CountdownViewController () {
    
    
    
}

@end

@implementation CountdownViewController {
    
    
    MainTimerScene * _timerScene;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}




- (void)viewWillLayoutSubviews
{
    
    [super viewWillLayoutSubviews];
    
    //timerLabel.text = @"1:00";
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    if (!skView.scene) {
        skView.showsFPS = NO;
        skView.showsNodeCount = NO;
        
        /*
        // Create and configure the scene.
        MainTimerScene *scene = [MainTimerScene sceneWithSize:skView.bounds.size];
        
        //SKScene * scene = [MainTimerScene sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        scene.timerSeconds = _timerSeconds;
        
        // Present the scene.
        [skView presentScene:scene];
         */
    
        // Create and configure the scene.
        
        _timerScene = [MainTimerScene sceneWithSize:skView.bounds.size];
        
        //SKScene * scene = [MainTimerScene sceneWithSize:skView.bounds.size];
        _timerScene.scaleMode = SKSceneScaleModeAspectFill;
        
        _timerScene.timerSeconds = _timerSeconds;
        
        // Present the scene.
        [skView presentScene:_timerScene];
        

    
    }
    
    
    // this may be where I need to check for rotation and somehow send a message to the skscene
    //NSLog(@"fires on rotation?");
    
    
    
}


// add something here to persist the timer info when the back button is pressed
- (void)viewWillDisappear:(BOOL)animated
{
    //NSLog(@"view will disappear, ta da!");
    [super viewWillDisappear:animated];
    
    if ([self isMovingFromParentViewController]){
        //specific stuff for being popped off stack
        //NSLog(@"back pressed, save elapsed time: %f seconds", _timerScene.countdownSeconds);
        
        self.parentController.previousTimerLeft = _timerScene.countdownSeconds;
    }
    
}


/* this is handled in the navigationController
- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscape;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}
*/ 


-(BOOL)prefersStatusBarHidden
{
    return YES;
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

@end

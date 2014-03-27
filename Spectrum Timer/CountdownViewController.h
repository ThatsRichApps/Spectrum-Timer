//
//  CountdownViewController.h
//  Spectrum Timer
//
//  Created by Rich Humphrey on 3/21/14.
//  Copyright (c) 2014 Rich Humphrey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "ViewController.h"

@interface CountdownViewController : UIViewController {

     
}

@property (nonatomic, assign) NSTimeInterval timerSeconds;
@property (nonatomic, strong) ViewController *parentController;
@end




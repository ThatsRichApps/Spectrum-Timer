//
//  MainTimerScene.m
//  Spectrum Timer
//
//  Created by Rich Humphrey on 3/21/14.
//  Copyright (c) 2014 Rich Humphrey. All rights reserved.
//

#import "MainTimerScene.h"

@implementation MainTimerScene {
    
    SKSpriteNode *_timerArrow;
    SKSpriteNode *_circle;
    SKSpriteNode *_pauseButton;
    SKSpriteNode *_rewindButton;
    SKLabelNode *_countdownTimer;
    BOOL _paused;
    CGPoint _velocity;
    CGPoint _lastTouchLocation;
    BOOL _timerDone;
    NSDate *_startTime;
    NSDate *_pauseBeginTime;
    NSTimeInterval _pauseElapsedTime;
    
}

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        
        
        _paused = false;
        
        _startTime = [NSDate date];
        _pauseElapsedTime = 0;
        
        //self.backgroundColor = [SKColor whiteColor];
        
        _timerDone = NO;
        
        _timerArrow = [SKSpriteNode spriteNodeWithImageNamed:@"arrow8"];
        _timerArrow.anchorPoint= CGPointMake(0.5, 0.002);
        //_timerArrow.position = CGPointMake(100, 100);
        _timerArrow.position = CGPointMake(self.size.width / 2, 0.5 * self.size.height);
        _timerArrow.name = @"timerArrow";

        [self addChild:_timerArrow];
        
        
        _circle = [SKSpriteNode spriteNodeWithImageNamed:@"spectrum circle 7"];
        _circle.anchorPoint= CGPointMake(0.5, 0.5);
        //_circle.position = CGPointMake(100, 100);
        _circle.position = CGPointMake(self.size.width / 2, 0.5 * self.size.height);
        _circle.name = @"circle";
        [self addChild:_circle];
        
        _countdownTimer = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        _countdownTimer.fontColor = [SKColor blackColor];
        _countdownTimer.position = CGPointMake(self.size.width / 2, 0.8 * self.size.height);
        _countdownTimer.name = @"countdownTimer";
        [self addChild:_countdownTimer];
        
        
        _pauseButton= [SKSpriteNode spriteNodeWithImageNamed:@"pause6"];
        _pauseButton.position = CGPointMake(0.65 * self.size.width, self.size.height / 6);
        _pauseButton.name = @"pauseButton";
        [self addChild:_pauseButton];
        
        
        _rewindButton= [SKSpriteNode spriteNodeWithImageNamed:@"rewind6"];
        _rewindButton.position = CGPointMake(0.35 * self.size.width, self.size.height / 6);
        _rewindButton.name = @"rewindButton";
        [self addChild:_rewindButton];
        
    }
    
    return self;
}


- (void)update:(NSTimeInterval)currentTime
{
    
    if (_paused) return;
    
    NSDate *nowTime = [NSDate date];
    NSTimeInterval timeInterval = [nowTime timeIntervalSinceDate:_startTime];
    //NSLog(@"time interval %f",timeInterval);
    
    //timerSeconds seconds count down
    NSTimeInterval timeIntervalCountDown = _timerSeconds - timeInterval + _pauseElapsedTime;
    
    self.countdownSeconds = timeIntervalCountDown;
    
    double normTime = timeIntervalCountDown / _timerSeconds;
    
    
    // rotate the arrow by 2 PI * (1 - normtime);
    //SKAction *rotateArrow = [SKAction rotateByAngle:(2 * M_PI * (1 - normTime)) duration:0.5];
    //[_timerArrow runAction:rotateArrow];
    
    _timerArrow.zRotation = (2 * M_PI * (1 - normTime));
    
    // wavelength is from 380 - 780, range of 400
    
    double wavelength = 380 + (260 * (1 - normTime));
    
    //NSLog(@"%f is wavelength", wavelength);
    
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeIntervalCountDown];
    
    // Create a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if (timeIntervalCountDown >= 3600) {
        
        [dateFormatter setDateFormat:@"hh:mm:ss"];
        
    } else {
    
        [dateFormatter setDateFormat:@"mm:ss"];
    
    }
    
    
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    
    // Format the elapsed time and set it to the label
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    
    _countdownTimer.text = timeString;
    
    float redValue;
    float greenValue;
    float blueValue;
    
    if (wavelength >= 380 && wavelength < 440) {
        
        redValue = -(wavelength - 440) / (440 - 380);
        greenValue = 0.0;
        blueValue = 1.0;
        
        
    } else if (wavelength >= 440 && wavelength < 490) {
        
        redValue = 0.0;
        greenValue = (wavelength - 440) / (490 - 440);
        blueValue = 1.0;
    
    } else if (wavelength >= 490 && wavelength < 510) {
        
        redValue = 0.0;
        greenValue = 1.0;
        blueValue = -(wavelength - 510) / (510 - 490);
        
    } else if (wavelength >= 510 && wavelength < 580) {
        
        redValue = (wavelength - 510) / (580 - 510);
        greenValue = 1.0;
        blueValue = 0.0;

    } else if (wavelength >= 580 && wavelength < 645) {
        
        redValue = 1.0;
        greenValue = -(wavelength - 645) / (645 - 580);
        blueValue = 0.0;
        
    } else if (wavelength >= 645 && wavelength <= 780) {
        
        redValue = 1.0;
        greenValue = 0.0;
        blueValue = 0.0;
        
    } else {
    
        redValue = 1.0;
        greenValue = 0.0;
        blueValue = 0.0;
        
    }
    
    self.backgroundColor = [SKColor colorWithRed:redValue green:greenValue blue:blueValue alpha: 1.0];
    
    if (timeIntervalCountDown <= 0) {
        
        _countdownTimer.text = @"00:00";
        
        // stop the countdown!
        self.scene.view.paused = YES;
        
    }
    
    
}


-(void) pauseTimer {
    
    //NSLog(@"pause the timer");
    
    // replace the pause button with a play button
    
    // if it's already paused - play, otherwise, pause
    if (_paused) {
        
        // start the timer again
        _paused = false;
        _pauseButton.texture = [SKTexture textureWithImageNamed:@"pause6"];
        
        NSDate *pauseEndTime = [NSDate date];
        _pauseElapsedTime = _pauseElapsedTime + [pauseEndTime timeIntervalSinceDate:_pauseBeginTime];
        
        //NSLog(@"paused for %f",_pauseElapsedTime);
        
    } else {
        
        // Pause the timer
        _paused = true;
        _pauseButton.texture = [SKTexture textureWithImageNamed:@"play2"];

        // mark where the time was stopped
        _pauseBeginTime = [NSDate date];
        //NSLog(@"time interval %f",timeInterval);

        
    }
    
    
    
    
    
}






-(void) resetTimer {
    
    _paused = FALSE;
    _pauseElapsedTime = 0;
    
    
    //SKAction *rotateBack = [SKAction rotateByAngle:(-1 * _timerArrow.zRotation) duration:60];
    
    //[_timerArrow runAction:rotateBack];
    
    _startTime = [NSDate date];
    
    // if the scene was paused , then reset it
    
    if (self.scene.view.paused) {
        
        self.scene.view.paused = NO;
        
    }
    
    
}




- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    //NSLog (@"touches began");
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    
    SKNode *node = [self nodeAtPoint:touchLocation];
    if ([node isEqual:_pauseButton]) {
        //NSLog(@"pause button was touched!");
        [self pauseTimer];
        
    }
    
    if ([node isEqual:_rewindButton]) {
        //NSLog(@"rewind button was touched!");
        [self resetTimer];
    }
    
    
    
    
}

/*
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}
*/
 

@end

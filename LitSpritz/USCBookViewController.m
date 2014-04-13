//
//  USCBookViewController.m
//  LitSpritz
//
//  Created by Clayton on 4/12/14.
//  Copyright (c) 2014 Spritz. All rights reserved.
//

#import "USCBookViewController.h"
#import <Spritz-SDK/SpritzSDK.h>
#import <Spritz-SDK/SpritzController.h>

@interface USCBookViewController () <SpritzControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *bookTitleDisplay;
@property (weak, nonatomic) IBOutlet SpritzInlineView *spritzInlineView;
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;

- (IBAction)sliderValueChanged:(id)sender;
- (IBAction)backButtonPressed:(id)sender;

@end

@implementation USCBookViewController {

    BOOL isPaused;
    SpritzController *sc;
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isPaused = YES;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (self.book) {
        [self.bookTitleDisplay setText:[self.book title]];
        [self.spritzInlineView addSpritzControllerDelegate:self];
        
        [self.speedSlider setValue:[SpritzDataStore sharedStore].userSettings.wordsPerMinute];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startOrStopSpritz:(id)sender {
    
        //The SpritzInlineView class is a UIView subclass that can be inititated from a UIStoryboard. The startSpritzing method starts spritzing the passed in URL.
        
        // Let's load a file
        //NSString *filePath = [[NSBundle mainBundle] pathForResource:[self.book fileName] ofType:@"txt"];
        
        // Let's make it a string
       /* NSString *stringFromFileAtPath = [[NSString alloc]initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        
        NSLog(@"%@", stringFromFileAtPath);*/
    
        sc = [self.spritzInlineView valueForKey:@"_spritzController"];
    
        if (!sc.started) {
            NSString *bookText = [self getStringStartingWithIndex:self.book.currentPosition];
            [self.spritzInlineView startSpritzing:bookText sourceType:SourceFlagPlain];
        }
        else {
            [sc togglePause];
        }
}

- (IBAction)sliderValueChanged:(id)sender {
    [SpritzDataStore sharedStore].userSettings.wordsPerMinute = [self.speedSlider value];
}

- (IBAction)backButtonPressed:(id)sender {
    sc = [self.spritzInlineView valueForKey:@"_spritzController"];
    //[sc goBackASentence];
     
    //[self goToCharWithIndex:100];
}

- (NSString*)getStringStartingWithIndex:(int)index {
    NSString *string = [self.book getString];
    NSString *newString = [string substringWithRange:NSMakeRange(index, [string length]-index)];
    return newString;
}

- (void)onStart:(int)charPos wordPos:(int)wordPos timePos:(float)timePos speed:(int)speed {
    
}
- (void)onPause:(int)charPos wordPos:(int)wordPos timePos:(float)timePos speed:(int)speed {
    
    // when we pause, we must save our current position for the book
    
    NSArray *strings = [[self.book getString] componentsSeparatedByString:@" "];
    NSUInteger sum = 0;
    for (int i =0; i < wordPos; i++) {
        sum += [[strings objectAtIndex:i] length];
    }
    sum = sum + wordPos - 1;

    self.book.currentPosition = sum;
    
    [self.delegate onPauseDelegation];
}

- (void)onResume:(int)charPos wordPos:(int)wordPos timePos:(float)timePos speed:(int)speed {
    
}
- (void)onStop:(int)charPos wordPos:(int)wordPos timePos:(float)timePos speed:(int)speed {
    
}
- (void)onGoBackASentence:(int)charPos wordPos:(int)wordPos timePos:(float)timePos speed:(int)speed {
    
}
- (void)onGoBackToStart:(int)charPos wordPos:(int)wordPos timePos:(float)timePos speed:(int)speed {
    
}
- (void)onCompleted:(int)charPos wordPos:(int)wordPos timePos:(float)timePos speed:(int)speed {
    
}


@end



/*
 
 
 so on pause
 [self.book.string componentsSeperatedByStrings:@" "];
 NSUInteger sum = 0;
 for (int i =0; i < wordPos; i++) {
    sum += [[strings objectAtIndex:i] length];
 }
 sum = sum + wordPos - 1;
 position is charPos
 
 
 */

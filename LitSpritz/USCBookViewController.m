//
//  USCBookViewController.m
//  LitSpritz
//
//  Created by Clayton on 4/12/14.
//  Copyright (c) 2014 Spritz. All rights reserved.
//

#import "USCBookViewController.h"
#import "USCChaptersViewController.h"
#import <Spritz-SDK/SpritzSDK.h>
#import <Spritz-SDK/SpritzController.h>

@interface USCBookViewController () <SpritzControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *bookTitleDisplay;
@property (weak, nonatomic) IBOutlet SpritzInlineView *spritzInlineView;
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;
@property (weak, nonatomic) IBOutlet UIButton *lastSentenceButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *chaptersButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *bookmarksButton;

- (IBAction)sliderValueChanged:(id)sender;
- (IBAction)backButtonPressed:(id)sender;

@end

@implementation USCBookViewController {

    BOOL isPaused;
    BOOL reload;
    SpritzController *sc;
    UIColor* trojanRed;
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isPaused = YES;
        reload = NO;
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
        [self.spritzInlineView setUserInteractionEnabled:NO];
        [self.speedSlider setValue:[SpritzDataStore sharedStore].userSettings.wordsPerMinute];
        trojanRed = [self.speedSlider minimumTrackTintColor];
        self.navigationController.navigationBar.tintColor = trojanRed;

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
    } else if (reload) {
        [sc stop];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            NSString *bookText = [self getStringStartingWithIndex:self.book.currentPosition];
            [self.spritzInlineView startSpritzing:bookText sourceType:SourceFlagPlain];
        });
        
        
        reload = NO;
    }
    else {
        if (isPaused)
            [sc pause];
        else [sc resume];
    }
    
    // when we pause, we should switch the button icon
    UIButton *theButton = (UIButton*)sender;
    if (isPaused == NO) {
        [theButton setImage:[UIImage imageNamed:@"pauseSmall.png"] forState:UIControlStateNormal];
    } else {
        [theButton setImage:[UIImage imageNamed:@"playSmall.png"] forState:UIControlStateNormal];
    }
    isPaused = !isPaused;
    
    // when we play, we should fade out the title and colors
    if (isPaused == YES) {
        [UIView animateWithDuration:2.4 animations:^{
            self.bookTitleDisplay.alpha = 0;
            self.speedSlider.minimumTrackTintColor = [UIColor grayColor];
            self.navigationController.navigationBar.tintColor =[UIColor grayColor];
            [self.lastSentenceButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            self.bookmarksButton.tintColor = [UIColor grayColor];
            self.chaptersButton.tintColor = [UIColor grayColor];
            
        }completion:^(BOOL finished) {
            self.chaptersButton.enabled = NO;
                    }];
    } else {
        [UIView animateWithDuration:1.0 animations:^{
            self.bookTitleDisplay.alpha = 1;
            self.speedSlider.minimumTrackTintColor = trojanRed;
            self.navigationController.navigationBar.tintColor = trojanRed;
            [self.lastSentenceButton setTitleColor:trojanRed forState:UIControlStateNormal];
            self.bookmarksButton.tintColor = trojanRed;
            self.chaptersButton.tintColor = trojanRed;
            self.chaptersButton.enabled = YES;
        }completion:^(BOOL finished) {
            
        }];
    }
    
}

- (IBAction)sliderValueChanged:(id)sender {
    [SpritzDataStore sharedStore].userSettings.wordsPerMinute = [self.speedSlider value];
}

- (IBAction)backButtonPressed:(id)sender {
    sc = [self.spritzInlineView valueForKey:@"_spritzController"];
    if (!isPaused) {
        [sc goBackASentence];
        [sc pause];
    } else {
        /*[sc pause];
        [sc goBackASentence];
        [sc resume];*/
    }
    
    //[self goToCharWithIndex:100];
}

- (NSString*)getStringStartingWithIndex:(int)index {
    NSString *string = [self.book getString];
    NSString *newString = [string substringWithRange:NSMakeRange(index, [string length]-index)];
    return newString;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //USCChaptersViewController *chaptersView = [segue destinationViewController];
    if ([[segue identifier] isEqualToString: @"chaptersSegue"]) {
        UINavigationController *navController = [segue destinationViewController];
        USCChaptersViewController *vc = navController.viewControllers[0];
        vc.book = self.book;
        
        reload = true;
        
    }
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

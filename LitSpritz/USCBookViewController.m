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

@end

@implementation USCBookViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.bookTitleDisplay setText:@"Huck Finn"];
    [self.spritzInlineView addSpritzControllerDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startOrStopSpritz:(id)sender {
    
        //The SpritzInlineView class is a UIView subclass that can be inititated from a UIStoryboard. The startSpritzing method starts spritzing the passed in URL.
        
        // Let's load a file
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"LewisCarrollThroughTheLookingGlass" ofType:@"txt"];
        
        // Let's make it a string
        NSString *stringFromFileAtPath = [[NSString alloc]initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        
        NSLog(@"%@", stringFromFileAtPath);
        [self.spritzInlineView startSpritzing:stringFromFileAtPath sourceType:SourceFlagPlain];
    
    
    /*    SpritzViewController *spritzVC = [[SpritzViewController alloc] init];
        [self presentViewController:spritzVC animated:YES completion:^{
            [spritzVC startSpritzing:stringFromFileAtPath sourceType:SourceFlagPlain];
        }];  */

}

- (void)onStart:(int)charPos wordPos:(int)wordPos timePos:(float)timePos speed:(int)speed {
    
}
- (void)onPause:(int)charPos wordPos:(int)wordPos timePos:(float)timePos speed:(int)speed {
    
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

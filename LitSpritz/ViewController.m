//
//  ViewController.m
//  Hello World
//
//  Created by Drew Ingebretsen on 4/10/14.
//  Copyright (c) 2014 Spritz. All rights reserved.
//

#import "ViewController.h"
#import <Spritz-SDK/SpritzSDK.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *spritzStyleSegmentedControl;
@property (weak, nonatomic) IBOutlet SpritzInlineView *spritzInlineView;

@end

@implementation ViewController

// To change word speed, go into UserSettingsLogic header and change wordspeed variable

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startSpritz:(id)sender {
    if (self.spritzStyleSegmentedControl.selectedSegmentIndex == 0){
        
        //The SpritzInlineView class is a UIView subclass that can be inititated from a UIStoryboard. The startSpritzing method starts spritzing the passed in URL.
        
       // [self.spritzInlineView startSpritzing:@"http://sdk.spritzinc.com/sampleText/HelloWorld.html" sourceType:SourceFlagURL];
        
        //http://api.ihackernews.com/page
        
        // Let's load a file
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"LewisCarrollThroughTheLookingGlass" ofType:@"txt"];

        // Let's make it a string
        NSString *stringFromFileAtPath = [[NSString alloc]initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];

        NSLog(@"%@", stringFromFileAtPath);
        [self.spritzInlineView startSpritzing:stringFromFileAtPath sourceType:SourceFlagPlain];
    }
    else{
        if (self.spritzStyleSegmentedControl.selectedSegmentIndex == 1){
            
            //The SpritzViewController is self contained UIViewController that contains a SpritzInlineView and several utility controls. The startSpritzing method starts spritzing the passed in URL.
            
            SpritzViewController *spritzVC = [[SpritzViewController alloc] init];
            [self presentViewController:spritzVC animated:YES completion:^{
                [spritzVC startSpritzing:@"http://sdk.spritzinc.com/sampleText/HelloWorld.html" sourceType:SourceFlagURL];
            }];
        }
    }
}

@end

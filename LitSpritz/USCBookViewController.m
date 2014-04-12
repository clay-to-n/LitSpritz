//
//  USCBookViewController.m
//  LitSpritz
//
//  Created by Clayton on 4/12/14.
//  Copyright (c) 2014 Spritz. All rights reserved.
//

#import "USCBookViewController.h"
#import <Spritz-SDK/SpritzSDK.h>

@interface USCBookViewController ()

@property (weak, nonatomic) IBOutlet UILabel *bookTitleDisplay;
@property (weak, nonatomic) IBOutlet SpritzInlineView *spritzInlineView;

@end

@implementation USCBookViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    [self.bookTitleDisplay setText:@"Huck Finn"];
    
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

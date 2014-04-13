//
//  USCBookViewController.h
//  LitSpritz
//
//  Created by Clayton on 4/12/14.
//  Copyright (c) 2014 Spritz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USCBookModel.h"

@protocol USCBookViewControllerDelegate <NSObject>
- (void)onPauseDelegation;
@end

@interface USCBookViewController : UIViewController

@property (nonatomic, weak) id <USCBookViewControllerDelegate>delegate;

@property (strong, nonatomic) NSString* bookTitle;
@property USCBookModel* book;

- (NSString*)getStringStartingWithIndex:(int)index;

@end

//
//  USCBookViewController.h
//  LitSpritz
//
//  Created by Clayton on 4/12/14.
//  Copyright (c) 2014 Spritz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USCBookModel.h"

@interface USCBookViewController : UIViewController

@property (strong, nonatomic) NSString* bookTitle;
@property USCBookModel* book;
@end

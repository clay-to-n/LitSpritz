//
//  USCBookModel.m
//  LitSpritz
//
//  Created by Clayton on 4/12/14.
//  Copyright (c) 2014 Spritz. All rights reserved.
//

#import "USCBookModel.h"

@interface USCBookModel ()

@property (assign, nonatomic) int id;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *fileName;
@property (assign, nonatomic) int currentPosition;
@property (strong, nonatomic) NSArray *chapterPositions;
@property (strong, nonatomic) NSDate *lastRead;

@end

@implementation USCBookModel

@end

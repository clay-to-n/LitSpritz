//
//  USCBookModel.h
//  LitSpritz
//
//  Created by Clayton on 4/12/14.
//  Copyright (c) 2014 Spritz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface USCBookModel : NSObject

@property (assign, nonatomic) int id;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *fileName;
@property (assign, nonatomic) int currentPosition;
@property (strong, nonatomic) NSMutableDictionary *chapterPositions;
@property (strong, nonatomic) NSDate *lastRead;

-(id) initWithTitle: (NSString *) title andAuthor: (NSString *) author andFileName: (NSString *) fileName;
-(NSString *) getString;
@end

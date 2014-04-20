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
@property (strong, nonatomic) NSData *data;
@property (assign, nonatomic) int currentPosition;
@property (strong, nonatomic) NSMutableDictionary *chapterPositions;
@property (strong, nonatomic) NSDate *lastRead;
@property (strong, nonatomic) NSString *fileFormat;

-(id) initWithTitle: (NSString *) title andAuthor: (NSString *) author andFileName: (NSString *) fileName;
-(id) initWithTitle: (NSString *) title andAuthor: (NSString *) author andData: (NSData *) data;
-(NSString *) getString;
@end

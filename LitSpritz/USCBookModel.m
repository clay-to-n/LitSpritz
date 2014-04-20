//
//  USCBookModel.m
//  LitSpritz
//
//  Created by Clayton on 4/12/14.
//  Copyright (c) 2014 Clayton Brand. All rights reserved.
//

#import "USCBookModel.h"

@interface USCBookModel ()



@end

@implementation USCBookModel

-(id) initWithTitle: (NSString *) title andAuthor: (NSString *) author andFileName: (NSString *) fileName {
    if (self = [super init]) {
        self.title = title;
        self.author = author;
        self.fileName = fileName;
        self.data = nil;
        self.currentPosition = 0;
        self.chapterPositions = self.findChapterPositions;
    }
    return self;
}
    
-(id) initWithTitle: (NSString *) title andAuthor: (NSString *) author andData: (NSData *) data
{
    if (self = [super init]) {
        self.title = title;
        self.author = author;
        self.fileName = nil;
        self.data = data;
        self.currentPosition = 0;
        self.chapterPositions = self.findChapterPositions;
    }
    return self;
}

// Returns the entire body of this book as a string
-(NSString *) getString {
    NSString *string;
    if (self.fileName != nil) {
        string = [[NSString alloc]initWithContentsOfFile:self.fileName encoding:NSUTF8StringEncoding error:nil];
    } else if (self.data != nil) {
        string = [[NSString alloc]initWithData:self.data encoding:NSUTF8StringEncoding];
    }
    return string;
}

-(NSMutableDictionary *) findChapterPositions {
    NSMutableDictionary *positions = [NSMutableDictionary dictionary];
    
    for (int i = 0; i < 30; i++) {
        int location = [self.getString rangeOfString:[NSString stringWithFormat:@"CHAPTER %d",i]].location;
        if ([self.getString rangeOfString:[NSString stringWithFormat:@"CHAPTER %d",i]].location != NSNotFound) {
            //[positions setValue:[NSNumber numberWithInt:location] forKey:[NSNumber numberWithInt:i]];
            [positions setObject:[[NSNumber alloc] initWithInt:location] forKey:[[NSNumber alloc] initWithInt:i]];
        }
    }
    
    return positions;
}

@end

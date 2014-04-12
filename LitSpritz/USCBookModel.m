//
//  USCBookModel.m
//  LitSpritz
//
//  Created by Clayton on 4/12/14.
//  Copyright (c) 2014 Spritz. All rights reserved.
//

#import "USCBookModel.h"

@interface USCBookModel ()



@end

@implementation USCBookModel

-(id) initWithTitle: (NSString *) title andFileName: (NSString *) fileName {
    if (self = [super init]) {
        self.title = title;
        self.fileName = fileName;
    }
    return self;
}

@end

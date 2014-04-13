//
//  USCBooksModel.m
//  LitSpritz
//
//  Created by Clayton on 4/12/14.
//  Copyright (c) 2014 Spritz. All rights reserved.
//

#import "USCBooksLibrary.h"

@interface USCBooksLibrary ()

@property (strong, nonatomic) NSMutableArray *books;

@property (strong, nonatomic) NSString *filepath;
@property (strong, nonatomic) NSMutableDictionary *plist;

@end

@implementation USCBooksLibrary

-(id) init {
    self = [super init];
    if (self) {
        self.books = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSInteger) numberOfBooks {
    return [self.books count];
}

- (USCBookModel *) bookAtIndex: (NSUInteger) index {
    return [self.books objectAtIndex:index];
}

- (void) removeBookAtIndex: (NSUInteger) index {
    [self.books removeObjectAtIndex:index];
    return;
}

- (void) insertBook: (USCBookModel *) book atIndex: (NSUInteger) index {
    [self.books insertObject:book atIndex:index];
    return;
}


@end

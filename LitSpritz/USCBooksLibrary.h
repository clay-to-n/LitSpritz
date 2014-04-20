//
//  USCBooksModel.h
//  LitSpritz
//
//  Created by Clayton on 4/12/14.
//  Copyright (c) 2014 Spritz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "USCBookModel.h"

@protocol USCBooksLibraryDelegate <NSObject>
@optional
    - (void) didUpdateLibrary;
@end

@interface USCBooksLibrary : NSObject

@property (nonatomic, assign) id delegate;
- (NSInteger) numberOfBooks;
- (USCBookModel *) bookAtIndex: (NSUInteger) index;
- (void) removeBookAtIndex: (NSUInteger) index;
- (void) insertBook: (USCBookModel *) book;
- (void) addBookFromURLString: (NSString *) bookURLString;
- (void)setDelegate:(id)newDelegate;

@end




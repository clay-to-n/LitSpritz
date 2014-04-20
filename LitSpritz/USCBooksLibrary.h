//
//  USCBooksModel.h
//  LitSpritz
//
//  Created by Clayton on 4/12/14.
//  Copyright (c) 2014 Spritz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "USCBookModel.h"

@interface USCBooksLibrary : NSObject

- (NSInteger) numberOfBooks;
- (USCBookModel *) bookAtIndex: (NSUInteger) index;
- (void) removeBookAtIndex: (NSUInteger) index;
- (void) insertBook: (USCBookModel *) book atIndex: (NSUInteger) index;
- (void) addBookFromURLString: (NSString *) bookURLString;

@end



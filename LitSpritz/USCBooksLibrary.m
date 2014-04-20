//
//  USCBooksModel.m
//  LitSpritz
//
//  Created by Clayton on 4/12/14.
//  Copyright (c) 2014 Spritz. All rights reserved.
//

#import "USCBooksLibrary.h"
#import "DownloadHelper.h"

@interface USCBooksLibrary () <DownloadHelperDelegate>

@property (strong, nonatomic) DownloadHelper *downloadHelper;
@property (strong, nonatomic) NSMutableArray *books;

@property (strong, nonatomic) NSString *filepath;
@property (strong, nonatomic) NSMutableDictionary *plist;

@end

@implementation USCBooksLibrary

-(id) init {
    self = [super init];
    if (self) {
        self.books = [[NSMutableArray alloc] init];
        self.downloadHelper = [DownloadHelper sharedInstance];

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
    
- (void) addBookFromURLString: (NSString *) bookURLString {
    
    NSString *extension = [[bookURLString lastPathComponent] pathExtension];
    if ([extension isEqualToString:@"txt"]) {
        [DownloadHelper download:bookURLString];
    }
}


@end

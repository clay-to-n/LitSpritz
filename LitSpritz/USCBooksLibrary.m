//
//  USCBooksModel.m
//  LitSpritz
//
//  Created by Clayton on 4/12/14.
//  Copyright (c) 2014 Clayton Brand. All rights reserved.
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

@synthesize delegate;
    
-(id) init {
    self = [super init];
    if (self) {
        self.delegate = nil;
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

- (void) insertBook: (USCBookModel *) book {
    [self.books insertObject:book atIndex:self.numberOfBooks];
    return;
}
    
- (void) addBookFromURLString: (NSString *) bookURLString {
    
    NSString *extension = [[bookURLString lastPathComponent] pathExtension];
    if ([extension isEqualToString:@"txt"] || [extension isEqualToString:@"utf-8"]) {
        self.downloadHelper = [DownloadHelper sharedInstance];
        [DownloadHelper download:bookURLString];
        self.downloadHelper.delegate = self;
    } else if ([extension isEqualToString:@"epub"]) {
        self.downloadHelper = [DownloadHelper sharedInstance];
        [DownloadHelper download:bookURLString];
        self.downloadHelper.delegate = self;
    }
}
    
// download helper delegate methods
- (void) didReceiveData: (NSData *) theData {
    NSString *title = [[self.downloadHelper.urlString lastPathComponent] stringByDeletingPathExtension];
    
    USCBookModel *newBook = [[USCBookModel alloc] initWithTitle:title andAuthor: @"Unknown Author" andData:theData];
    [self insertBook:newBook];
    
    [self.delegate didUpdateLibrary];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Book added." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alert show];
}
    
- (void) didReceiveFilename: (NSString *) aName {
    
}
    
- (void) dataDownloadFailed: (NSString *) reason {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"The URL is not valid." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alert show];
}
    
- (void) dataDownloadAtPercent: (NSNumber *) aPercent {
    
}


@end

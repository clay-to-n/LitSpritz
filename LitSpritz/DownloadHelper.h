//
//  DownloadHelper.h
//  LitSpritz
//
//  This class created by:
//  Erica Sadun, http://ericasadun.com
//  iPhone Developer's Cookbook, 5.0 Edition
//  BSD License, Use at your own risk
//

@protocol DownloadHelperDelegate <NSObject>
@optional
- (void) didReceiveData: (NSData *) theData;
- (void) didReceiveFilename: (NSString *) aName;
- (void) dataDownloadFailed: (NSString *) reason;
- (void) dataDownloadAtPercent: (NSNumber *) aPercent;
@end

@interface DownloadHelper : NSObject
    {
        NSURLResponse *response;
        NSMutableData *data;
        NSString *urlString;
        NSURLConnection *urlconnection;
        id <DownloadHelperDelegate> delegate;
        BOOL isDownloading;
    }
    @property (retain) NSURLResponse *response;
    @property (retain) NSURLConnection *urlconnection;
    @property (retain) NSMutableData *data;
    @property (retain) NSString *urlString;
    @property (retain) id delegate;
    @property (assign) BOOL isDownloading;
    
+ (instancetype) sharedInstance;
+ (void) download:(NSString *) aURLString;
+ (void) cancel;
@end
//
//  CPAAppDelegate.h
//  CPA
//
//  Created by Liu Jianming on 13-2-19.
//  Copyright (c) 2013年 Liu Jianming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CPAReport;
@class CPAHistory;

@interface CPAAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
    
    //To hold a list of DraftReport objects
    NSMutableArray *reportArray;
    
    //To hold a list of SentReport objects
    NSMutableArray *historyArray;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property (nonatomic, retain) NSMutableArray *reportArray;
@property (nonatomic, retain) NSMutableArray *historyArray;

- (void) copyDatabaseIfNeeded;
- (NSString *) getDBPath;

- (void) removeReport:(CPAReport *)reportObj;
- (void) addReport:(CPAReport *)reportObj;
- (void) saveReport;
- (void) refreshReport;

- (void) removeHistory:(CPAHistory *)historyObj;
- (void) addHistory:(CPAHistory *)historyObj;
- (void) saveHistory;
- (void) refreshHistory;


@end

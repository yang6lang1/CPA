//
//  CPADraftHistoryViewController.h
//  CPA
//
//  Created by Liu Jianming on 13-3-19.
//  Copyright (c) 2013年 Liu Jianming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CPAHistory;
@class CPADetailHistoryViewController;

@interface CPADraftHistoryViewController : UITableViewController
{
    IBOutlet UITableView *tabView;
    CPAAppDelegate *appDelegate;
    CPADetailHistoryViewController *dvController;
    
}
@end



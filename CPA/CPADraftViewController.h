//
//  CPADetailViewController.h
//  CPA
//
//  Created by Liu Jianming on 13-2-19.
//  Copyright (c) 2013年 Liu Jianming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CPAReport;
@class CPADetailViewController;

@interface CPADraftViewController : UITableViewController
<UIAlertViewDelegate>{
        IBOutlet UITableView *tabView;
        CPAAppDelegate *appDelegate;
        CPADetailViewController *dvController;
    
}

@end


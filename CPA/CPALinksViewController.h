//
//  CPALinksViewController.h
//  CPA
//
//  Created by Liu Jianming on 13-3-21.
//  Copyright (c) 2013年 Liu Jianming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPALinksViewController : UITableViewController
<UITableViewDelegate,UITableViewDataSource>
- (IBAction)VPDWebsite:(id)sender;
- (IBAction)VPDMissingPerson:(id)sender;
- (IBAction)VPDWantedList:(id)sender;
- (IBAction)CityService:(id)sender;
@end

//
//  CPADetailHistoryViewController.h
//  CPA
//
//  Created by Liu Jianming on 13-3-19.
//  Copyright (c) 2013年 Liu Jianming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CPAHistory;

@interface CPADetailHistoryViewController : UITableViewController
{
    CPAHistory *passingHistoryObj;
}

@property (weak, nonatomic) IBOutlet UILabel *categoryField;
@property (weak, nonatomic) IBOutlet UILabel *timeField;
@property (weak, nonatomic) IBOutlet UILabel *latitudeField;
@property (weak, nonatomic) IBOutlet UILabel *longitudeField;
@property (weak, nonatomic) IBOutlet UITextView *forAddressField;
@property (weak, nonatomic) IBOutlet UITextView *commentField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) CPAHistory *passingHistoryObj;
@end

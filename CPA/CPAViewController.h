//
//  OurAppViewController.h
//  MainMenu
//
//  Created by Liu Jianming on 13-2-13.
//  Copyright (c) 2013年 Liu Jianming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CPAProfileViewController;

@interface CPAViewController : UIViewController
<UIAlertViewDelegate>
{
  //  CPAAppDelegate *appDelegate;
    
    CPAProfileViewController *profileViewController;
    BOOL isLogin;
}

@property (strong, nonatomic) IBOutlet UIButton *buttonReport;
@property (strong, nonatomic) IBOutlet UIButton *buttonDraft;
@property (strong, nonatomic) IBOutlet UIButton *buttonHistory;
@property (strong, nonatomic) IBOutlet UIButton *buttonProfile;
@property (strong, nonatomic) IBOutlet UIButton *buttonLinks;
@property (strong, nonatomic) IBOutlet UIButton *buttonHelp;
@property (strong, nonatomic) IBOutlet UIButton *buttonAboutUs;

@property (readwrite,nonatomic) BOOL isLogin;//login status //True = login, False= not login

- (IBAction)profileButtonPressed:(id)sender;
@end

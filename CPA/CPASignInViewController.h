//
//  CPASignInViewController.h
//  CPA
//
//  Created by Liu Jianming on 13-3-13.
//  Copyright (c) 2013年 Liu Jianming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPASignInViewController : UIViewController
<UIAlertViewDelegate,UITextFieldDelegate>
{
    UITextField *usernameField;
    UITextField *passwordField;
}
@property (retain, nonatomic) IBOutlet UITextField *usernameField;
@property (retain, nonatomic) IBOutlet UITextField  *passwordField;

-(IBAction)textFieldDoneEditing:(id)sender;
-(IBAction)backgroundTap:(id)sender;
-(IBAction)signInButtonPressed:(id)sender;

@end

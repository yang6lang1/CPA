//
//  CPAProfileViewController.h
//  CPA
//
//  Created by Liu Jianming on 13-3-15.
//  Copyright (c) 2013年 Liu Jianming. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ksubmitURL  @"http://tract_cpa.0fees.net/profileUpdate.php"
#define kusername  @"username"
#define kpassword  @"password"
#define kemail     @"email"
#define knumber    @"contactNumber"
#define kcode      @"identityCode"
#define kfirst     @"firstName"
#define klast      @"lastName"

@interface CPAProfileViewController : UITableViewController
<UIAlertViewDelegate>
{
    UILabel *usernameField;
    UITextField *passwordField;
    UITextField *confirmPasswordField;
    UITextField *emailField;
    UITextField *contactNumberField;
    UITextField *identityCodeField;
    UITextField *firstNameField;
    UITextField *lastNameField;

}

@property (retain, nonatomic) IBOutlet UILabel *usernameField;
@property (retain, nonatomic) IBOutlet UITextField *passwordField;
@property (retain, nonatomic) IBOutlet UITextField *confirmPasswordField;
@property (retain, nonatomic) IBOutlet UITextField *emailField;
@property (retain, nonatomic) IBOutlet UITextField *contactNumberField;
@property (retain, nonatomic) IBOutlet UITextField *identityCodeField;
@property (retain, nonatomic) IBOutlet UITextField *firstNameField;
@property (retain, nonatomic) IBOutlet UITextField *lastNameField;

- (IBAction)saveButtonPressed:(id)sender;

@end

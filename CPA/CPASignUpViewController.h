//
//  CPASignUpViewController.h
//  CPA
//
//  Created by Liu Jianming on 13-3-13.
//  Copyright (c) 2013年 Liu Jianming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

#define ksubmitURL  @"http://tract_cpa.0fees.net/signUp.php"
//#define ksubmitURL  @"http://localhost/signUp.php"
#define kusername  @"username"
#define kpassword  @"password"
#define kemail     @"email"
#define knumber    @"contactNumber"
#define kcode      @"identityCode"
#define kfirst     @"firstName"
#define klast      @"lastName"

@interface CPASignUpViewController : UITableViewController
<UIAlertViewDelegate,UITextFieldDelegate>
{
    UITextField *usernameField;
    UITextField *passwordField;
    UITextField *confirmPasswordField;
    UITextField *emailField;
    UITextField *contactNumberField;
    UITextField *identityCodeField;
    UITextField *firstNameField;
    UITextField *lastNameField;
    
    NSURLConnection *signUp;
    
}
@property (retain, nonatomic) IBOutlet UITextField *usernameField;
@property (retain, nonatomic) IBOutlet UITextField *passwordField;
@property (retain, nonatomic) IBOutlet UITextField *confirmPasswordField;
@property (retain, nonatomic) IBOutlet UITextField *emailField;
@property (retain, nonatomic) IBOutlet UITextField *contactNumberField;
@property (retain, nonatomic) IBOutlet UITextField *identityCodeField;
@property (retain, nonatomic) IBOutlet UITextField *firstNameField;
@property (retain, nonatomic) IBOutlet UITextField *lastNameField;

- (IBAction)submitButtonPressed:(id)sender;
-(IBAction)textFieldDoneEditing:(id)sender;

@end

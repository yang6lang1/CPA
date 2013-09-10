//
//  CPAProfileViewController.m
//  CPA
//
//  Created by Liu Jianming on 13-3-15.
//  Copyright (c) 2013年 Liu Jianming. All rights reserved.
//

#import "CPAProfileViewController.h"

#define allTrim( object ) [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ]


@interface CPAProfileViewController ()

@end

@implementation CPAProfileViewController
@synthesize usernameField,passwordField,confirmPasswordField,emailField;
@synthesize contactNumberField,identityCodeField,firstNameField,lastNameField;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  //remainder:after changing profile info, MyManager data need to be updated!
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    MyManager *loginInfo = [MyManager getInstance ];
    usernameField.text = loginInfo.username;
    
    NSString *post =[NSString stringWithFormat:@"username=%@", usernameField.text];
    
    NSString *hostStr = @"http://tract_cpa.0fees.net/fetchProfile.php?";
    hostStr = [hostStr stringByAppendingString:post];
    NSData *dataURL =  [NSData dataWithContentsOfURL:[NSURL URLWithString: hostStr]];
    NSString *serverOutput = [[NSString alloc] initWithData:dataURL encoding: NSASCIIStringEncoding];
    serverOutput = [serverOutput stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSArray *split = [serverOutput componentsSeparatedByString:@"/StringSeperator/"];
    
    usernameField.text = split[0];
    passwordField.text = split[1];
    confirmPasswordField.text =split[1];
    emailField.text = split[2];
    contactNumberField.text = split[3];
    identityCodeField.text = split[4];
    lastNameField.text = split[5];
    firstNameField.text = split[6];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewDidUnload {
    [self setUsernameField:nil];
    [self setPasswordField:nil];
    [self setConfirmPasswordField:nil];
    [self setEmailField:nil];
    [self setContactNumberField:nil];
    [self setIdentityCodeField:nil];
    [self setFirstNameField:nil];
    [self setLastNameField:nil];
    [super viewDidUnload];
}

-(NSString *) profileUpdate: (NSString *) username
              withPassword: (NSString *) password
                 withEmail: (NSString *) email
                withNumber: (NSString *) contactNumber
                  withCode: (NSString *) identityCode
                 withFirst: (NSString *) firstName
                  withLast: (NSString *) lastName
{
    NSMutableString *sendString = [NSMutableString stringWithString: ksubmitURL];
    
    [sendString appendString:[NSString stringWithFormat:@"?%@=%@", kusername, username]];
    
    [sendString appendString:[NSString stringWithFormat:@"&%@=%@", kpassword, password]];
    
    [sendString appendString:[NSString stringWithFormat:@"&%@=%@", kemail, email]];
    
    [sendString appendString:[NSString stringWithFormat:@"&%@=%@", knumber, contactNumber]];
    
    [sendString appendString:[NSString stringWithFormat:@"&%@=%@", kcode, identityCode]];
    
    [sendString appendString:[NSString stringWithFormat:@"&%@=%@", klast, lastName]];
    
    [sendString appendString:[NSString stringWithFormat:@"&%@=%@", kfirst, firstName]];
    
    [sendString setString:[sendString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *dataURL =  [NSData dataWithContentsOfURL:[NSURL URLWithString: sendString]];
    
    NSString *serverOutput = [[NSString alloc] initWithData:dataURL encoding: NSASCIIStringEncoding];
    return serverOutput;
}


- (IBAction)saveButtonPressed:(id)sender {
    //TODO: update the database in webserver
    NSString *errMessage=NULL;
    errMessage =[self checkingError];
    //return if message not pass, otherwise proceed to check the existence of account
    if(errMessage != NULL){[self showErrorMsg:errMessage];
        return;
    }

    // call function profileUpdate and run profileUpdate.php on localhost(profileUpdate.php updates the account in AccountTable)
    NSString *serverOutput= [self profileUpdate:usernameField.text withPassword:passwordField.text withEmail:emailField.text withNumber:contactNumberField.text withCode:identityCodeField.text withFirst:firstNameField.text withLast:lastNameField .text];
    
    if([serverOutput isEqualToString:@"Profile Updated"]){
        NSLog(@"account successfully updated!");
        [self accountSuccessfullyUpdated];
    } else {
        errMessage = @"Please don't use special symbols.\neg: ',$,#";
        [self showErrorMsg:errMessage];
        
    }
    
}

-(NSString *)checkingError{
    NSString *errMessage1;
   // pass=false;
    
    //case 1: required field empty
    errMessage1= [self requiredFieldEmptyCheck];
    if ([errMessage1 isEqualToString:@"Please finish the information in the required field"]) {
        return errMessage1;
    }
    
    //case 2: password don't match
    NSString *errMessage2 =[self passwordDontMatch];
    return errMessage2;
    
}

-(NSString *)requiredFieldEmptyCheck{
 //   pass = false;
    NSString *errMessage= NULL;
    //this line detects if the username,password,confirmPassword,email fields are empty or consist of empty 'space's
    if (isEmpty(usernameField.text)||[allTrim( usernameField.text ) length] == 0
        ||isEmpty(passwordField.text)||[allTrim( passwordField.text ) length] == 0
        ||isEmpty(confirmPasswordField.text)||[allTrim( confirmPasswordField.text ) length] == 0
        ||isEmpty(emailField.text)||[allTrim( emailField.text ) length] == 0 ) {
        errMessage =@"Please finish the information in the required field";
    }else{
  //      pass = true;
    }
    return errMessage;
}

// Check if the "thing" pass'd is empty
static inline BOOL isEmpty(id thing) {
    return thing == nil
    || (thing == [NSNull null])
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
}


-(NSString *)passwordDontMatch{
    //pass = false;
    NSString *errMessage = NULL;
    
    if ([passwordField.text isEqualToString:confirmPasswordField.text]) {
   //r     pass= true;
    }else
    {
        errMessage = @"Password don't match.";
    }
    return errMessage;
}

-(void)showErrorMsg:(NSString *)errMessage{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail to update profile!" message:errMessage                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [alert show];
    
}

-(void) accountSuccessfullyUpdated{
    // open an alert with two custom buttons
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Account successfully updated!" message:[NSString stringWithFormat:@"Username: %@", usernameField.text]                                                   delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
	[alert show];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
    
}

@end

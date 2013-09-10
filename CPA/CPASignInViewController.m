//
//  CPASignInViewController.m
//  CPA
//
//  Created by Liu Jianming on 13-3-13.
//  Copyright (c) 2013年 Liu Jianming. All rights reserved.
//

#import "CPASignInViewController.h"
#import "CPAViewController.h"
@interface CPASignInViewController ()

@end

@implementation CPASignInViewController
@synthesize usernameField,passwordField;
BOOL pass2 = false;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
  //  self.view.backgroundColor = [UIColor clearColor];
    
   // [self.view addSubview:iv];
    //[self.view sendSubviewToBack:iv];

}

#define kOFFSET_FOR_KEYBOARD 80.0

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
   // if ([sender isEqual:mailTf])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}

-(IBAction)backgroundTap:(id)sender {
    [self.usernameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

-(void)signInButtonPressed:(id)sender{
    NSString *errMessage;
    
    NSString *post =[NSString stringWithFormat:@"username=%@&password=%@", usernameField.text, passwordField.text];
    
    NSString *hostStr = @"http://tract_cpa.0fees.net/signIn.php?";
    hostStr = [hostStr stringByAppendingString:post];
    NSData *dataURL =  [NSData dataWithContentsOfURL:[NSURL URLWithString: hostStr]];
    NSString *serverOutput = [[NSString alloc] initWithData:dataURL encoding: NSASCIIStringEncoding];
  
    serverOutput = [serverOutput stringByReplacingOccurrencesOfString:@" " withString:@""];

    if([serverOutput isEqualToString:@"Yes"]){
        //the user is logged in now
    MyManager *loginStatus = [MyManager getInstance ];
        loginStatus.isLogin = YES;
        loginStatus.username = usernameField.text;//set this global username variable
        // later in the ProfileView, I am going to call fetchProfile.php to fetch all the information associated with that username
    [self accountSuccessfullyLogin];
    } else {
        errMessage = @"Incorrect Username or Password.";
        [self showErrorMsg:errMessage];
    }

}

-(void) accountSuccessfullyLogin{
    // open an alert with two custom buttons
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sign in successful!" message:@"Now you can send reports"                                                   delegate:self cancelButtonTitle:nil otherButtonTitles: @"OK",nil];
	[alert show];
        [self.navigationController popViewControllerAnimated:YES];

}

-(void)showErrorMsg:(NSString *)errMessage{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sign in fail!" message:errMessage                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [alert show];
    
}


@end

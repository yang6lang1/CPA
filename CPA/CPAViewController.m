//
//  OurAppViewController.m
//  MainMenu
//
//  Created by Liu Jianming on 13-2-13.
//  Copyright (c) 2013年 Liu Jianming. All rights reserved.
//

#import "CPAViewController.h"
#import "CPAProfileViewController.h"

@interface CPAViewController ()
{
    NSString *username;
}
@end

@implementation CPAViewController   

@synthesize buttonReport;
@synthesize buttonDraft;
@synthesize buttonHistory;
@synthesize buttonProfile;
@synthesize buttonLinks;
@synthesize buttonHelp;
@synthesize buttonAboutUs;
@synthesize isLogin;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   // appDelegate = (CPAAppDelegate *)[[UIApplication sharedApplication] delegate];

  /*  //BACKGROUND COLOUR!
    self.view.backgroundColor = [UIColor clearColor];
    UITableView *tv = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:tv];
    [self.view sendSubviewToBack:tv];
*/
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

-(void)viewWillAppear:(BOOL)animated{
    if  (animated){
        MyManager *loginStatus = [MyManager getInstance];
        isLogin = loginStatus.isLogin; // check the login status
        username = loginStatus.username;
    }
     if(!isLogin){
         MyManager *loginStatus = [MyManager getInstance];
         loginStatus.isLogin = false; // update the login status
        UIBarButtonItem *signInButton = [[UIBarButtonItem alloc]
                                         initWithTitle:@"Sign in"
                                         style:UIBarButtonItemStyleBordered
                                         target:self
                                         action:@selector(signInButton_Clicked:)];
        //self.navigationItem.leftBarButtonItem = signInButton;
         [self.navigationItem setLeftBarButtonItem:signInButton animated:YES];
    }
    if(isLogin){

        UIBarButtonItem *signOutButton = [[UIBarButtonItem alloc]
                                         initWithTitle:@"Sign out"
                                         style:UIBarButtonItemStyleBordered
                                         target:self
                                         action:@selector(signOutButton_Clicked:)];

        [self.navigationItem setLeftBarButtonItem:signOutButton animated:YES];
    }

}

- (IBAction) signInButton_Clicked:(id)sender {
    [self performSegueWithIdentifier:@"SignInSegue" sender:nil];
}

- (IBAction) signOutButton_Clicked:(id)sender {
    isLogin = true;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Are you sure to sign out?" message:[NSString stringWithFormat:@"Username: %@",username]                                                     delegate:self cancelButtonTitle:nil otherButtonTitles:@"No",@"Yes", nil];

    [alert show];

}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
            isLogin = false;
            [self viewWillAppear:NO];
//            [self performSegueWithIdentifier:@"SignInSegue" sender:nil];

            break;

        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)profileButtonPressed:(id)sender {

if (isLogin){
    [self performSegueWithIdentifier:@"profileSegue" sender:nil];
}
   else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Access denied!" message:@"Please sign in first"                                                      delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alert show];
    }
    

}

@end

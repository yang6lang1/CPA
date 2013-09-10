//
//  CPALinksViewController.m
//  CPA
//
//  Created by Liu Jianming on 13-3-21.
//  Copyright (c) 2013年 Liu Jianming. All rights reserved.
//

#import "CPALinksViewController.h"

@interface CPALinksViewController ()

@end

@implementation CPALinksViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)VPDWebsite:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://vancouver.ca/police/"]];
}

- (IBAction)VPDMissingPerson:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://cfapp.vancouver.ca/MissingPersons_wac/MissingPersons.exe"]];

}

- (IBAction)VPDWantedList:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://cfapp.vancouver.ca/mostwanted_wac/mostWanted.exe?image=yes"]];
}

- (IBAction)CityService:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://vancouver.ca/police/community-policing/city-services-who-to-call.html"]];

}
@end

//
//  CPADetailHistoryViewController.m
//  CPA
//
//  Created by Liu Jianming on 13-3-19.
//  Copyright (c) 2013年 Liu Jianming. All rights reserved.
//

#import "CPADetailHistoryViewController.h"
#import "CPAHistory.h"

@interface CPADetailHistoryViewController ()

@end

@implementation CPADetailHistoryViewController
@synthesize passingHistoryObj;
@synthesize categoryField,timeField,latitudeField,longitudeField,forAddressField,commentField,imageView;

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
    categoryField.text = passingHistoryObj.category;
    forAddressField.text = passingHistoryObj.location;
    commentField.text = passingHistoryObj.comments;
    timeField.text = passingHistoryObj.time;
    latitudeField.text = passingHistoryObj.latitude;
    longitudeField.text = passingHistoryObj.longitude;
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.clipsToBounds = YES;
    [imageView setImage:[self loadImage:passingHistoryObj.imageLocation]];
   // NSLog(passingHistoryObj.imageLocation);

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

//fetch image from the filepath
- (UIImage *)loadImage:(NSString *)filePath  {
    return [UIImage imageWithContentsOfFile:filePath];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidUnload {
    [self setCategoryField:nil];
    [self setTimeField:nil];
    [self setLatitudeField:nil];
    [self setLongitudeField:nil];
    [self setForAddressField:nil];
    [self setCommentField:nil];
    [self setImageView:nil];
    [super viewDidUnload];
}
@end

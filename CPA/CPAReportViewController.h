//
//  CPAReportViewController.h
//  CPA
//
//  Created by Liu Jianming on 13-2-19.
//  Copyright (c) 2013年 Liu Jianming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
//#import <sqlite3.h>


#define kreportURL  @"http://tract_cpa.0fees.net/sendReport.php"
#define kdate  @"date1"
#define kcategory  @"category1"
#define ktime     @"time1"
#define klocation    @"location1"
#define kcomments      @"comments1"
#define kimageRUL     @"imageURL1"
#define klatitude      @"latitude1"
#define klongitude  @"longitude1"
#define kusername   @"username1"


@interface CPAReportViewController : UITableViewController
  <UIActionSheetDelegate,UITextFieldDelegate,UITextViewDelegate,CLLocationManagerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
{
    
    //for UIDatePickerView
    UITextField *timeField;
    NSDate *date;
    UIActionSheet *dateSheet;
    
    //for UIActionSheet
    UILabel *categoryField;
    
    //for getLocation(GPS)
    UITextField *locationField;
    
    //for comments
    UITextView  *commentField;
    
    //for adding photo
    IBOutlet UIImageView *imageView;
    UIImagePickerController *picker;
    UIImagePickerController *picker2;
    UIImage *image;
    NSString *imageLocation;
    
    //for saving function
  //  sqlite3 *db;
    
    //for sending
    NSURLConnection *submitReport;


}

-(IBAction)sendButtonPressed:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *buttonSend;

//for UIActionSheet
@property (nonatomic,retain) IBOutlet UILabel *categoryField;
-(IBAction)categoryButtonPressed:(id)sender;
//*******************

//for UIDatePickerView
//@property (nonatomic,weak) IBOutlet UILabel *timeField;
@property (retain, nonatomic) NSDate *date;
@property (nonatomic, retain) IBOutlet UITextField *timeField;
-(IBAction)dateButtonPressed:(id)sender;

-(void)setDate;
-(void)dismissDateSet;
-(void)cancelDateSet;
//*******************

//for getLocation(GPS)

@property (strong, nonatomic) IBOutlet UIButton *buttonGetLocation;
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UITextView *forAddressText;
@property (nonatomic, strong) IBOutlet UIButton *doneButtonForAddress;

-(IBAction)getLocationButtonPressed:(id)sender;
//-(IBAction)textfieldReturn:(id)sender; //disable the keyboard when pressing "Done"
//******************* 

//for comments
@property (nonatomic,strong) IBOutlet UITextView  *commentField;
@property (nonatomic, strong) IBOutlet UIButton *doneButton;
-(IBAction)doneButtonPressed:(id)sender;
//*******************

//for adding photo
//-(IBAction)takePhoto;
//-(IBAction)chooseExisting;
@property (strong, nonatomic) IBOutlet UIButton *addPhotoButton;
- (IBAction)addPhotoButtonPressed:(id)sender;
-(void)takePhoto;
-(void)chooseExisting;
@property (strong,retain) NSString *imageLocation;
//*******************

//for saving function
-(IBAction)saveButtonPressed:(id)sender;
//*******************


@end

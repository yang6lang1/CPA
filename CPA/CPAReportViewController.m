//
//  CPAReportViewController.m
//  CPA
//
//  Created by Liu Jianming on 13-2-19.
//  Copyright (c) 2013年 Liu Jianming. All rights reserved.
//

#import "CPAReportViewController.h"
#import "CPAReport.h"   
#import "CPAHistory.h"
#import "AFNetworking.h"
#define allTrim( object ) [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ]

@interface CPAReportViewController ()

@end

@implementation CPAReportViewController{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;

}


@synthesize buttonSend = buttonSend;
@synthesize imageLocation;

//for UIDatePickerView
@synthesize date =_date;
@synthesize timeField =timeField;

//for UIActionSheet
@synthesize categoryField = categoryField;

//for getLocation(GPS)
@synthesize buttonGetLocation = _buttonGetLocation;
@synthesize forAddressText;
@synthesize latitudeLabel;
@synthesize longitudeLabel;

//for comments
@synthesize commentField = commentField;
@synthesize doneButton = doneButton;

//for saving function
@synthesize doneButtonForAddress,addPhotoButton;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
   //for categoryField & UIActionSheet
    categoryField.text = @"Please select a category";
    latitudeLabel.text = @"Latitude";
    longitudeLabel.text= @"Longitude";

    //for timeField & UIDatePickerView
    // your label text is set to current time
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd hh:mm a"];
  //  [timeField setText:[dateFormatter stringFromDate:self.date]];
    //   [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    //   [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    //   [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *currentTime = [dateFormatter stringFromDate:[NSDate date]];
    timeField.text= currentTime;//[[NSDate date] description];
    // timer is set & will be triggered each second
    //[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showTime) userInfo:nil repeats:YES];*/
   
    //for adding photo
    imageView.contentMode = UIViewContentModeScaleAspectFit;    
    imageView.clipsToBounds = YES;

    //for getLocation(GPS)
    locationManager= [[CLLocationManager alloc]init];
    geocoder = [[CLGeocoder alloc]init];

    //for saving function
     
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [self setForAddressText:nil];
    [self setLongitudeLabel:nil];
    [self setLatitudeLabel:nil];
    [self setDate:nil];
   // [self setCategory:nil];
    //  [self setTimeField:nil];
    //[self setTimeField:nil];
    //[super viewDidUnload];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TODOLIST
//IMPORTANT FUNCTIONs
/*
 Need to figure out:
 1. How to save data locally
 2. How to access GPS and get location
 3. How to access photo and camera to get pictures and display(compress) them
 4. How to send to the database in the form of .csv
 */






#pragma mark - UIActionSheet

-(void)categoryButtonPressed:(id)sender{
     [self setCategory];
}

- (void)setCategory
{
	// open a dialog with two custom buttons
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Category"
                                                             delegate:self
                                                    cancelButtonTitle:nil destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Traffic disorder", @"Missing vehicle",@"Missing people", @"Suspicious people", @"Graffiti",@"Other", nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	//actionSheet.destructiveButtonIndex = 1;	// make the second button red (destructive)
	[actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
    //	[actionSheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            categoryField.text = @"Traffic disorder";
            break;
        case 1:
            categoryField.text = @"Missing vehicle";
            break;
        case 2:
            categoryField.text = @"Missing people";
            break;
        case 3:
            categoryField.text = @"Suspicious people";
            break;
        case 4:
            categoryField.text = @"Graffiti";
            break;
        case 5:
            categoryField.text = @"Other";
            
        default:
            break;
    }
}

//**********************


#pragma mark - UIDatePickerView
-(void)dateButtonPressed:(id)sender{
    [self setDate];
}

-(void)setDate {
    dateSheet =[[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    [dateSheet setActionSheetStyle:(UIActionSheetStyleBlackTranslucent)];
    
    CGRect pickerFrame = CGRectMake(0, 44, 0, 0);
    UIDatePicker *dayPicker = [[UIDatePicker alloc]initWithFrame:pickerFrame];
//    [dayPicker setDatePickerMode:UIDatePickerModeDate];
    [dayPicker setDatePickerMode:UIDatePickerModeDateAndTime];

    
    [dateSheet addSubview:dayPicker];
    
    
    UIToolbar *controlToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, dateSheet.bounds.size.width, 44)];
    
    [controlToolBar setBarStyle:UIBarStyleBlack];
    [controlToolBar sizeToFit];
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *setButton = [[UIBarButtonItem alloc] initWithTitle:@"Set" style:UIBarButtonItemStyleDone target:self action:@selector(dismissDateSet)];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style: UIBarButtonItemStyleBordered target:self action:@selector(cancelDateSet)];
    
    [controlToolBar setItems:[NSArray arrayWithObjects:spacer, cancelButton, setButton, nil] animated:NO];
    [dateSheet addSubview:controlToolBar];
    
    [dateSheet showInView:self.view];
    
    [dateSheet setBounds:CGRectMake(0, 0, 320, 485)];
    
}

-(void)cancelDateSet {
    [dateSheet dismissWithClickedButtonIndex:0 animated:YES];
    
}

-(void)dismissDateSet {
    NSArray *listOfViews = [dateSheet subviews];
    
    for(UIView *subView in listOfViews){
        if([subView isKindOfClass:[UIDatePicker class]]){
            self.date = [(UIDatePicker *)subView date];
        }
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"MM/dd hh:mm a"];
    [timeField setText:[dateFormatter stringFromDate:self.date]];
    
    [dateSheet dismissWithClickedButtonIndex:0 animated:YES];
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
   [self setDate];
    return NO;
}
//**********************

#pragma mark - getLocation(GPS)
- (void)getLocationButtonPressed:(id)sender {
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    /*
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManager startUpdatingLocation];
     _locationField.text = [NSString stringWithFormat:@" latutude: %f, longtitude: %f",
                                 locationManager.location.coordinate.latitude,
                                 locationManager.location.coordinate.longitude];
*/
  }


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    if (currentLocation != nil) {
        longitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        latitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    }

    // Stop Location Manager
    [locationManager stopUpdatingLocation];
    
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            forAddressText.text = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                    placemark.subThoroughfare, placemark.thoroughfare,
                                    placemark.postalCode, placemark.locality,
                                    placemark.administrativeArea,
                                    placemark.country];
            
            //     forAddressText.text =[NSString stringWithFormat:@"%@ %@",placemark.subThoroughfare, placemark.thoroughfare];
                                  
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
    
}
//**********************


#pragma mark - comments

-(void)doneButtonPressed:(id)sender{
    [self.view endEditing:TRUE];
}
//**********************


#pragma mark - add photo
-(void)addPhotoButtonPressed:(id)sender{
    [self UserOption];
}
- (void)UserOption
{
	// open an alert with two custom buttons
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please select a photo from" message:NULL
                                                   delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Camera", @"Photo Gallery", nil];
	[alert show];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
            [self takePhoto];
            break;
        case 2:
            [self  chooseExisting];
            break;
            
        default:
            break;
    }
}

-(void)takePhoto{
    picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:picker animated:YES completion:NULL];
    
}

-(void)chooseExisting{
    picker2 = [[UIImagePickerController alloc]init];
    picker2.delegate = self;
    [picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:picker2 animated:YES completion:NULL];
}


-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
 /*
    CGFloat newWidth, newHeight;
    CGFloat aspectRatioForImage = image.size.height/image.size.width;
    CGFloat aspectRatioForImageView = imageView.bounds.size.height/imageView.bounds.size.width;
    if (aspectRatioForImage >= aspectRatioForImageView) {
        //The height needs to be resized
        newHeight = imageView.bounds.size.height;
        newWidth = newHeight /aspectRatioForImage;
    }else
    {
        newWidth = imageView.bounds.size.width;
        newHeight = newWidth *aspectRatioForImage;
    }
*/
 //   UIImage *resizedImage;
 //   resizedImage = [self scaleImage:image toSize:CGSizeMake(imageView.bounds.size.width, imageView.bounds.size.height)];
  //    imageView.clipsToBounds = YES;
    //[imageView setImage:resizedImage];
    [imageView setImage:image];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

/*
// Change image size without change image ratio
-(UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize
{
    float width = newSize.width;
    float height = newSize.height;
    UIGraphicsBeginImageContext(newSize);
    CGRect rect = CGRectMake(0, 0, width, height);
    
    float widthRatio = image.size.width / width;
    float heightRatio = image.size.height / height;
    float divisor = widthRatio > heightRatio ? widthRatio : heightRatio;
    
    width = image.size.width / divisor;
    height = image.size.height / divisor;
    
    rect.size.width  = width;
    rect.size.height = height;
    //TODO --------- How To Center The Resized Image????
    //   rect.origin.x =10;
    //   rect.origin.y = 10;
    
    if(height < width)
        rect.origin.y = height / 3;
    [image drawInRect: rect];
    
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return smallImage;
    
    
}*/ //this function might be useful later

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
//**********************

#pragma mark - Saving Function

-(IBAction)saveButtonPressed:(id)sender{
    if ([categoryField.text isEqualToString:@"Please select a category"]) {
        [self savingUnsuccessfully];
    }else{

    CPAAppDelegate *appDelegate = (CPAAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //Create a CPAReport Object.
    CPAReport *reportObj = [[CPAReport alloc] initWithPrimaryKey:0];

        NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
        [dateFormatter2 setDateFormat:@"MM/dd hh:mm:ss a"];
        //  [timeField setText:[dateFormatter stringFromDate:self.date]];
        //   [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        //   [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        //   [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
        NSString *currentTime = [dateFormatter2 stringFromDate:[NSDate date]];
        reportObj.date = currentTime;
        
    reportObj.category = categoryField.text;
    reportObj.time = timeField.text;

    reportObj.location = forAddressText.text;
    reportObj.latitude=latitudeLabel.text;
    reportObj.longitude= longitudeLabel.text;

    reportObj.comments = commentField.text;
        //save image in the document directory, save the path into database and name the image with 'category time'.png
        NSString *imageName = [NSString stringWithFormat:@"%@ %@",reportObj.category,reportObj.date];
        imageName = [imageName stringByReplacingOccurrencesOfString:@" " withString:@"-"];
        imageName = [imageName stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
        imageName = [imageName stringByReplacingOccurrencesOfString:@":" withString:@"-"];
        reportObj.imageLocation = [self saveImage:image forPerson:imageName];
        
    reportObj.isDirty = NO;
    reportObj.isDetailViewHydrated = YES;
    
    //Add the object
    [appDelegate addReport:reportObj];
        
    [self.navigationController popViewControllerAnimated:YES];
    //    [self performSegueWithIdentifier:@"GoToDraftSegue" sender:nil];

          
    }
}


- (NSString *)saveImage:(UIImage *)imageToSave forPerson:(NSString *)fullName  {
    //  Make file name first
    NSString *filename = [fullName stringByAppendingString:@".png"]; // or .jpg
    
    //  Get the path of the app documents directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //  Append the filename and get the full image path
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:filename];
    
    //  Now convert the image to PNG/JPEG and write it to the image path
    NSData *imageData = UIImagePNGRepresentation(imageToSave);
    [imageData writeToFile:savedImagePath atomically:NO];
    
    //  Here you save the savedImagePath to your DB
    return savedImagePath;
}


-(void) savingUnsuccessfully{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Saving unsuccessfully!" message:@"Please select a category"
                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert show];

    
}

- (void)savingSuccessfully
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Saving successfully!" message:@"You can check from Draft"
                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert show];
}


#pragma mark - for sending
-(void) SendReport: (NSString *) date1
        withCategory: (NSString *) category1
           withTime: (NSString *) time1
          withLocation: (NSString *) location1
            withcomments: (NSString *) comments1
           withImageURL: (NSString *) imageURL1
      withLatitude: (NSString *) latitude1
     withLongitude: (NSString *) longitude1
      withUsername:  (NSString *) username1
{

        NSMutableString *sendString = [NSMutableString stringWithString: kreportURL];
        
        [sendString appendString:[NSString stringWithFormat:@"?%@=%@", kdate, date1]];
        
        [sendString appendString:[NSString stringWithFormat:@"&%@=%@", kcategory, category1]];
        
        [sendString appendString:[NSString stringWithFormat:@"&%@=%@", ktime, time1]];
        
        [sendString appendString:[NSString stringWithFormat:@"&%@=%@", klocation, location1]];
        
        [sendString appendString:[NSString stringWithFormat:@"&%@=%@", kcomments, comments1]];
        
        [sendString appendString:[NSString stringWithFormat:@"&%@=%@", kimageRUL, imageURL1]];
        
        [sendString appendString:[NSString stringWithFormat:@"&%@=%@", klatitude, latitude1]];

        [sendString appendString:[NSString stringWithFormat:@"&%@=%@", klongitude, longitude1]];
    
        [sendString appendString:[NSString stringWithFormat:@"&%@=%@", kusername, username1]];
    
        [sendString setString:[sendString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:sendString]];
        
        [request setHTTPMethod:@"POST"];
        
        submitReport = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];

}

-(void)sendButtonPressed:(id)sender{
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"MM/dd hh:mm:ss a"];
    NSString *currentTime = [dateFormatter2 stringFromDate:[NSDate date]];

    NSString *errMessage= NULL;
    MyManager *loginStatus = [MyManager getInstance ];
    NSLog(@"Report sent from: %@",loginStatus.username);
    if (!loginStatus.isLogin) {
        errMessage=@"Please log in first!\n You can save your report and send when you are logged in.";
        [self showErrorMsg:errMessage ];
        return;
    }
    errMessage= [self requiredFieldEmptyCheck];
    if ([errMessage isEqualToString:@"Please finish the information in the required field"]) {
        [self showErrorMsg:errMessage ];
        return;
    }else{    
        //send to local database: HistoryTable:
        CPAAppDelegate *appDelegate = (CPAAppDelegate *)[[UIApplication sharedApplication] delegate];

        //Create a CPAHistory Object.
        CPAHistory *historyObj = [[CPAHistory alloc] initWithPrimaryKey:0];
        
        NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
        [dateFormatter2 setDateFormat:@"MM/dd hh:mm:ss a"];
        //  [timeField setText:[dateFormatter stringFromDate:self.date]];
        //   [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        //   [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        //   [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
        NSString *currentTime = [dateFormatter2 stringFromDate:[NSDate date]];
        historyObj.date = currentTime;
        
        historyObj.category = categoryField.text;
        historyObj.time = timeField.text;
        
        historyObj.location = forAddressText.text;
        historyObj.latitude=latitudeLabel.text;
        historyObj.longitude= longitudeLabel.text;
        
        historyObj.comments = commentField.text;
        NSString *imageName = [NSString stringWithFormat:@"Sent-%@ %@",historyObj.category,historyObj.date];
        imageName = [imageName stringByReplacingOccurrencesOfString:@" " withString:@"-"];
        imageName = [imageName stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
        imageName = [imageName stringByReplacingOccurrencesOfString:@":" withString:@"-"];
        historyObj.imageLocation = [self saveImage:image forPerson:imageName];
        
        historyObj.isDirty = NO;
        historyObj.isDetailViewHydrated = YES;
        
        //Add the object
        [appDelegate addHistory:historyObj];
        
        
        //TODO:
        //1. Upload image to the webserver then store the URL into imageURL
       // imageName; //this is the image I just saved in the HistoryTable
        //send to the server:
        //1st: upload the image to server then get URL
        
        NSString *uploadedImgURL=NULL;
        if (imageView.image !=nil) {
        
        imageName = [imageName stringByAppendingString:@".png"]; // or .jpg

        NSURL *url = [NSURL URLWithString:@"http://tract_cpa.0fees.net/"];
        
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
        
        NSData *imageData = UIImageJPEGRepresentation(imageView.image, 1.0);
        
        NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:@"/uploadImage.php" parameters:nil constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
            [formData appendPartWithFileData:imageData name:@"uploadedfile" fileName:imageName mimeType:@"images/png"];
        }];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        
        [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
            NSLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
        }];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSString *response = [operation responseString];
             NSLog(@"response: [%@]",response);
             //[MBProgressHUD hideHUDForView:self.view animated:YES];
         }
                                         failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             //[MBProgressHUD hideHUDForView:self.view animated:YES];
             if([operation.response statusCode] == 403)
             {
                 NSLog(@"Upload Failed");
                 return;
             }
             NSLog(@"error: %@", [operation error]);
             
         }];
        
        
        [operation start];
        uploadedImgURL=@"http://tract_cpa.0fees.net/uploads/";
        uploadedImgURL = [uploadedImgURL stringByAppendingString:imageName];
        }
        //2nd: send the report to server:
        [self SendReport:currentTime withCategory:categoryField.text withTime:timeField.text withLocation:forAddressText.text withcomments:commentField.text withImageURL:uploadedImgURL withLatitude:latitudeLabel.text withLongitude:longitudeLabel.text withUsername:loginStatus.username];

        [self.navigationController popViewControllerAnimated:YES];
    }
}


-(NSString *)requiredFieldEmptyCheck{
    //pass = false;
    NSString *errMessage= NULL;
    //this line detects if the username,password,confirmPassword,email fields are empty or consist of empty 'space's
    if ([categoryField.text isEqualToString:@"Please select a category"]
        ||isEmpty(forAddressText.text)||[allTrim( forAddressText.text ) length] == 0
        ||isEmpty(commentField.text)||[allTrim( commentField.text ) length] == 0 ) {
        errMessage =@"Please finish the information in the required field";
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



-(void) sendSuccessfully{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Send successfully!" message:@"You can view sent reports in History"
                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert show];

}
-(void)showErrorMsg:(NSString *)errMessage{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Send unsuccessfully!" message:errMessage                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [alert show];
    
}
@end
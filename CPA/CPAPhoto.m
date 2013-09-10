//
//  CPAPhoto.m
//  CPA
//
//  Created by Liu Jianming on 13-3-3.
//  Copyright (c) 2013年 Liu Jianming. All rights reserved.
//

#import "CPAPhoto.h"

@interface CPAPhoto ()

@end

@implementation CPAPhoto

#pragma mark - 
-(IBAction)takePhoto{
    picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:picker animated:YES completion:NULL];
    
}

-(IBAction)chooseExisting{
    picker2 = [[UIImagePickerController alloc]init];
    picker2.delegate = self;
    [picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:picker2 animated:YES completion:NULL];
}


-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
 
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
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
    UIImage *resizedImage;
    resizedImage = [self scaleImage:image toSize:CGSizeMake(imageView.bounds.size.width, imageView.bounds.size.height)];

    [imageView setImage:resizedImage];
    [self dismissViewControllerAnimated:YES completion:NULL];
}


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
    
    
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


-(IBAction) doneButtonPressed:(id)sender
{
//TODO -------------  pass the image to ReportViewController so we can store it locally later
    
    [self.navigationController popViewControllerAnimated:YES];
    //  [self.taskListViewController.tableView reloadData];
}



@end

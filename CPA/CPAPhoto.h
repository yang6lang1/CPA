//
//  CPAPhoto.h
//  CPA
//
//  Created by Liu Jianming on 13-3-3.
//  Copyright (c) 2013年 Liu Jianming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPAPhoto : UIViewController
<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    // UIButton *takePictureButton;
    IBOutlet UIImageView *imageView;
    UIImagePickerController *picker;
    UIImagePickerController *picker2;
    UIImage *image;
    
}
-(IBAction)takePhoto;
-(IBAction)chooseExisting;


@end

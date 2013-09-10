//
//  MyManager.h
//  CPA
//
//  Created by Liu Jianming on 13-3-16.
//  Copyright (c) 2013年 Liu Jianming. All rights reserved.
//

#import <foundation/Foundation.h>

@interface MyManager : NSObject {
//    NSString *someProperty;
    BOOL isLogin;
    NSInteger accountID;
    NSString *username;
    NSString *password;
    NSString *email;
    //Optional:
    NSString *contactNumber;
    NSString *identityCode;
    NSString *lastName;
    NSString *FirstName;

    
}

@property (nonatomic, readwrite) BOOL isLogin;
@property (nonatomic, readonly) NSInteger accountID;
@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *password;
@property (nonatomic,copy) NSString *email;
@property (nonatomic,copy) NSString *contactNumber;
@property (nonatomic,copy) NSString *identityCode;
@property (nonatomic,copy) NSString *lastName;
@property (nonatomic,copy) NSString *firstName;

+(MyManager *) getInstance;
@end
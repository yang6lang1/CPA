//
//  MyManager.m
//  CPA
//
//  Created by Liu Jianming on 13-3-16.
//  Copyright (c) 2013年 Liu Jianming. All rights reserved.
//

#import "MyManager.h"

@implementation MyManager
@synthesize accountID,username,password,email;
@synthesize contactNumber,identityCode,lastName,firstName;

@synthesize isLogin;
static MyManager *instance =nil;

#pragma mark Singleton Methods
+(MyManager *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [MyManager  new];
        }
    }
    return instance;
}
@end
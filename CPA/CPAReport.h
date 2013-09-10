//
//  CPAReport.h
//  CPA
//
//  Created by Liu Jianming on 13-3-5.
//  Copyright (c) 2013年 Liu Jianming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface CPAReport : NSObject
{
    NSInteger reportID;
    NSString *date;
    NSString *category;
    NSString *time;
    NSString *location;
    NSString *comments;
    NSString *imageLocation;
    NSString *latitude;
    NSString *longitude;
    //Intrnal variables to keep track of the state of the object.
	BOOL isDirty;
	BOOL isDetailViewHydrated;
}

@property (nonatomic, readonly) NSInteger reportID;
//@property (nonatomic) NSInteger reportID;
@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *category;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *location;
@property (nonatomic,copy) NSString *comments;
@property (nonatomic,copy) NSString *imageLocation;
@property (nonatomic,copy) NSString *latitude;
@property (nonatomic,copy) NSString *longitude;

@property (nonatomic, readwrite) BOOL isDirty;
@property (nonatomic, readwrite) BOOL isDetailViewHydrated;

//static methods
+ (void) getInitialDataToDisplay:(NSString *)dbPath;
+ (void) finalizeStatements;

//Instance methods
- (id) initWithPrimaryKey:(NSInteger)pk;
- (void) deleteReport;
- (void) addReport;
- (void) saveAllData;
- (void) hydrateDetailViewData;


@end

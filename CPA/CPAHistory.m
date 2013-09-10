//
//  CPAHistory.m
//  CPA
//
//  Created by Liu Jianming on 13-3-20.
//  Copyright (c) 2013年 Liu Jianming. All rights reserved.
//

#import "CPAHistory.h"

static sqlite3 *database = nil;
static sqlite3_stmt *deleteStmt = nil;
static sqlite3_stmt *addStmt = nil;
static sqlite3_stmt *detailStmt = nil;
static sqlite3_stmt *updateStmt = nil;

@implementation CPAHistory
@synthesize reportID,date, category, time , location, comments,imageLocation,latitude,longitude;
@synthesize isDirty,isDetailViewHydrated;

+ (void) getInitialDataToDisplay:(NSString *)dbPath {
    
    CPAAppDelegate *appDelegate = (CPAAppDelegate *)[[UIApplication sharedApplication] delegate];
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        //for draft reports
        const char *sql = "select * from HistoryTable";
        
        sqlite3_stmt *selectstmt;
        if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
         //   [[NSUserDefaults standardUserDefaults] setObject: [NSString stringWithFormat:@"Yes"] forKey:@"history`Added"];
            while(sqlite3_step(selectstmt) == SQLITE_ROW) {
                
                NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
                CPAHistory *historyObj = [[CPAHistory alloc] initWithPrimaryKey:primaryKey];

                historyObj.date = [NSString stringWithFormat:@"%s", (char *) sqlite3_column_text(selectstmt, 1)];
                historyObj.category = [NSString stringWithFormat:@"%s", (char *) sqlite3_column_text(selectstmt, 2)];
                historyObj.time = [NSString stringWithFormat:@"%s", (char *) sqlite3_column_text(selectstmt, 3)];
                historyObj.location = [NSString stringWithFormat:@"%s", (char *) sqlite3_column_text(selectstmt, 4)];
                historyObj.comments = [NSString stringWithFormat:@"%s", (char *) sqlite3_column_text(selectstmt, 5)];
                historyObj.imageLocation = [NSString stringWithFormat:@"%s", (char *) sqlite3_column_text(selectstmt, 6)];
                historyObj.latitude = [NSString stringWithFormat:@"%s", (char *) sqlite3_column_text(selectstmt, 7)];
                historyObj.longitude = [NSString stringWithFormat:@"%s", (char *) sqlite3_column_text(selectstmt, 8)];
                historyObj.isDirty = NO;
                
                [appDelegate.historyArray addObject:historyObj];
            }
        }
    }
    else
        sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
}


- (id) initWithPrimaryKey:(NSInteger) pk {
    
    //   [super init];
    reportID = pk;
    [[NSUserDefaults standardUserDefaults] setObject: [NSString stringWithFormat:@"%d",reportID] forKey:@"reportID"];
    
    isDetailViewHydrated = NO;
    
    return self;
}

+ (void) finalizeStatements {
    
    if(database) sqlite3_close(database);
    if (deleteStmt) sqlite3_finalize(deleteStmt);
	if (addStmt) sqlite3_finalize(addStmt);
	if (detailStmt) sqlite3_finalize(detailStmt);
	if (updateStmt) sqlite3_finalize(updateStmt);
    
}

- (void) deleteHistory {
    
    if(deleteStmt == nil)
    {
        //sql query //‘?’ specifies that we have to pass a parameter to the statement, we do this using sqlite3_bind_int method since the parameter we have to pass is an int.
        const char *sql = "delete from HistoryTable where reportID = ?";
        if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
            NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
    }
    
    //When binding parameters, index starts from 1 and not zero.
    sqlite3_bind_int(deleteStmt, 1, reportID);
    
    if (SQLITE_DONE != sqlite3_step(deleteStmt))
        NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
    
    sqlite3_reset(deleteStmt);
}

- (void) addHistory {
    
    if(addStmt == nil)
    {
        const char *sql = "INSERT INTO HistoryTable(date, category, time , location, comments, imageURL,latitude,longitude) values(?,?,?,?,?,?,?,?)";
        if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
            NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
    }
    sqlite3_bind_text(addStmt, 1, [date UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 2, [category UTF8String], -1, SQLITE_TRANSIENT);
    
	sqlite3_bind_text(addStmt, 3, [time UTF8String], -1, SQLITE_TRANSIENT);
    
	sqlite3_bind_text(addStmt, 4, [location UTF8String], -1, SQLITE_TRANSIENT);
	
	sqlite3_bind_text(addStmt, 5, [comments UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 6, [imageLocation UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 7, [latitude UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 8, [longitude UTF8String], -1, SQLITE_TRANSIENT);
    
    if(SQLITE_DONE != sqlite3_step(addStmt))
        NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
    else
        //SQLite provides a method to get the last primary key inserted by using sqlite3_last_insert_rowid
        reportID = sqlite3_last_insert_rowid(database);
    //  NSLog(@"add successfully");
    //Reset the add statement.
    sqlite3_reset(addStmt);
}


- (void) hydrateDetailViewData {
	
	//If the detail view is hydrated then do not get it from the database.
	if(isDetailViewHydrated) return;
	
	if(detailStmt == nil) {
		const char *sql = "Select date, category, time, location, comments, imageURL ,latitude,longitude from HistoryTable Where ID = ?";
        
		if(sqlite3_prepare_v2(database, sql, -1, &detailStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating detail view statement. '%s'", sqlite3_errmsg(database));
	}
	
	//kc110609	sqlite3_bind_int(detailStmt, 1, contactID);
	sqlite3_bind_int(detailStmt, 1, reportID);
	
	if(SQLITE_DONE != sqlite3_step(detailStmt)) {
		;
	}
	else
		NSAssert1(0, @"Error while getting the price of coffee. '%s'", sqlite3_errmsg(database));
	
	//Reset the detail statement.
	sqlite3_reset(detailStmt);
	
	//Set isDetailViewHydrated as YES, so we do not get it again from the database.
	isDetailViewHydrated = YES;
}

- (void) saveAllData {
	
	if(isDirty) {
		
		if(updateStmt == nil) {
			const char *sql = "update HistoryTable Set date = ?, category = ?, time = ?, location = ?, comments = ?, imageURL = ?, latitude = ?, longitude = ?. Where reportID = ?";
			if(sqlite3_prepare_v2(database, sql, -1, &updateStmt, NULL) != SQLITE_OK)
				NSAssert1(0, @"Error while creating update statement. '%s'", sqlite3_errmsg(database));
		}
		
		sqlite3_bind_text(updateStmt, 1, [date UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(updateStmt, 2, [category UTF8String], -1, SQLITE_TRANSIENT);
        
		sqlite3_bind_text(updateStmt, 3, [time UTF8String], -1, SQLITE_TRANSIENT);
        
		sqlite3_bind_text(updateStmt, 4, [location UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(updateStmt, 5, [comments UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(updateStmt, 6, [imageLocation UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt, 7, [latitude UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt, 8, [longitude UTF8String], -1, SQLITE_TRANSIENT);
        
		sqlite3_bind_int(updateStmt, 9, reportID);
		
		if(SQLITE_DONE != sqlite3_step(updateStmt))
			NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(database));
		
		sqlite3_reset(updateStmt);
		
		isDirty = NO;
	}
    
	//Reclaim all memory here.
	date = nil;
	category = nil;
	time = nil;
	location = nil;
	comments = nil;
    imageLocation =nil;
    latitude = nil;
    longitude = nil;
	
	isDetailViewHydrated = NO;
}



- (void)setDate:(NSString *)newValue {
	
	self.isDirty = YES;
	date = [newValue copy];
	//kc111009	NSLog(@"set contact_id: %@",contact_id);
}

- (void)setCategory:(NSString *)newValue {
	
	self.isDirty = YES;
	category = [newValue copy];
}



- (void)setTime:(NSString *)newValue {
	
	self.isDirty = YES;
	time = [newValue copy];
}


- (void)setLocation:(NSString *)newLocation {
	
	self.isDirty = YES;
	location = [newLocation copy];
}
- (void)setComments:(NSString *)newValue {
	
	self.isDirty = YES;
	comments = [newValue copy];
}

- (void)setImageLocation:(NSString *)newValue {
	
	self.isDirty = YES;
	imageLocation = [newValue copy];
}

- (void)setLatitude:(NSString *)newValue {
	
	self.isDirty = YES;
	latitude = [newValue copy];
}


- (void)setLongitude:(NSString *)newValue{
    
	self.isDirty = YES;
	longitude = [newValue copy];
}


@end


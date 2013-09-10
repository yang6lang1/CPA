//
//  CPAAppDelegate.m
//  CPA
//
//  Created by Liu Jianming on 13-2-19.
//  Copyright (c) 2013年 Liu Jianming. All rights reserved.
//

#import "CPAAppDelegate.h"
#import "CPAViewController.h"
#import "CPAReport.h"
#import "CPAHistory.h"

@implementation CPAAppDelegate
@synthesize window = _window;
@synthesize navigationController = _navigationController;
@synthesize reportArray,historyArray;


- (void) copyDatabaseIfNeeded {
    
    //Using NSFileManager we can perform many file system operations.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    //connecting Report database
    NSString *dbPath = [self getDBPath];
    BOOL success = [fileManager fileExistsAtPath:dbPath];
   
    if(!success) {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Report.sql"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        if (!success) {
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
        }
    }
//for testing purpose
    //else{        NSLog([NSString stringWithFormat:@"name of database is:%@",dbPath]);}
    
}

- (NSString *) getDBPath {
    
    //Search for standard documents using NSSearchPathForDirectoriesInDomains
    //First Param = Searching the documents directory
    //Second Param = Searching the Users directory and not the System
    //Expand any tildes and identify home directories.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"Report.sql"];
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	//Copy database to the user's phone if needed.
	[self copyDatabaseIfNeeded];
	   
	//Initialize the transaction array.
	NSMutableArray *tempReportArray = [[NSMutableArray alloc] init];
	self.reportArray = tempReportArray;
    
    NSMutableArray *tempHistoryArray = [[NSMutableArray alloc]init];
    self.historyArray = tempHistoryArray;
    
	//Once the db is copied, get the initial data to display on the screen
	[CPAReport getInitialDataToDisplay:[self getDBPath]];
    [CPAHistory getInitialDataToDisplay:[self getDBPath]];

 
    [window makeKeyAndVisible];
    return YES;
}


//do the same with draftReport and sentReport
- (void) removeReport:(CPAReport *)reportObj{
  
    //Remove the picture from document directory
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *fullPath = reportObj.imageLocation;
    [fileManager removeItemAtPath:fullPath error:NULL];
    
    //Delete it from the database.
    [reportObj deleteReport];
    
    //Remove it from the array.
    [reportArray removeObject:reportObj];
   // [self refreshReport];
}

- (void)removeHistory:(CPAHistory *)historyObj{
    //Remove the picture from document directory
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *fullPath = historyObj.imageLocation;
    [fileManager removeItemAtPath: fullPath error:NULL];

    //Delete it from the database.
    [historyObj deleteHistory];
    
    //Remove it from the array.
    [historyArray removeObject:historyObj];
    // [self refreshReport];
}

- (void) addReport:(CPAReport *)reportObj{
    
    //Add it to the database.
    [reportObj addReport];
    
    //Add it to the coffee array.
    [reportArray addObject:reportObj];
   // [self refreshReport];

}

- (void)addHistory:(CPAHistory *)historyObj{
    
    //Add it to the database.
    [historyObj addHistory];
    
    //Add it to the coffee array.
    [historyArray addObject:historyObj];
    // [self refreshReport];

}

- (void) saveReport {
	[self.reportArray makeObjectsPerformSelector:@selector(saveAllData)];
    [self refreshReport];
}


- (void) refreshReport {
	//Initialize the report array.
/*	if ([reportArray retainCount] <= 1){
		[reportArray retain]; //kc0106
	}
*/
	
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	self.reportArray = tempArray;
	//Once the db is copied, get the initial data to display on the screen.
	[CPAReport getInitialDataToDisplay:[self getDBPath]];
}

- (void) saveHistory {
	[self.historyArray makeObjectsPerformSelector:@selector(saveAllData)];
    [self refreshHistory];
}


- (void) refreshHistory {
	//Initialize the report array.
    /*	if ([reportArray retainCount] <= 1){
     [reportArray retain]; //kc0106
     }
     */
	
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	self.historyArray = tempArray;
	//Once the db is copied, get the initial data to display on the screen.
	[CPAHistory getInitialDataToDisplay:[self getDBPath]];
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self.reportArray makeObjectsPerformSelector:@selector(saveAllData)];
	
	[CPAReport finalizeStatements];

    [self.historyArray makeObjectsPerformSelector:@selector(saveAllData)];
	
	[CPAHistory finalizeStatements];

}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    
    //Save all the dirty contact objects and free memory.
	[self.reportArray makeObjectsPerformSelector:@selector(saveAllData)];
    
}

@end

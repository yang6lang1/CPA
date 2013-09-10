//
//  CPADraftHistoryViewController.m
//  CPA
//
//  Created by Liu Jianming on 13-3-19.
//  Copyright (c) 2013年 Liu Jianming. All rights reserved.
//

#import "CPADraftHistoryViewController.h"
#import "CPAHistory.h"
#import "CPADetailHistoryViewController.h"

@interface  CPADraftHistoryViewController()

@end

@implementation CPADraftHistoryViewController

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    // return 0;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [appDelegate.historyArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"DraftCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //     cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //Get the object from the array.
    CPAHistory *historyObj = [appDelegate.historyArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@, %@",historyObj.category, historyObj.time];
    
    // Set up the cell
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(dvController == nil)
		dvController = [[CPADetailHistoryViewController alloc] initWithNibName:@"DetailView" bundle:nil];
    
    CPAHistory *historyObj = [appDelegate.historyArray objectAtIndex:indexPath.row];
    
    //We only load the data we initially want and keep on loading as we need.
	//[historyObj hydrateDetailViewData];//????

    //	[reportObj hydrateDetailViewData];
	dvController.passingHistoryObj = historyObj;
    
}

- (void)viewDidLoad
{
    appDelegate = (CPAAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
     
    self.title = @"History";
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated  //happens before the view is available
{
    [super viewWillAppear:animated];
 
  //  [self.tableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated  //happens after....
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        
        //Get the object to delete from the array.
        CPAHistory *historyObj = [appDelegate.historyArray objectAtIndex:indexPath.row];
        [appDelegate removeHistory:historyObj];//TODO
        
        //Delete the object from the table.
		[tabView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"ViewReportSegue"]){
        CPAHistory *historyObj = [appDelegate.historyArray objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        
        CPADetailHistoryViewController *detailViewController = segue.destinationViewController;
        detailViewController.passingHistoryObj = historyObj;
        //we need to figure out which task we are going to pass into
        //this will be determined by which role the user clicked in the table view
        // so we need to figure out the index of the row
    }
}



@end

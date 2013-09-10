//
//  CPADetailViewController.m
//  CPA
//
//  Created by Liu Jianming on 13-2-19.
//  Copyright (c) 2013年 Liu Jianming. All rights reserved.
//

#import "CPADraftViewController.h"
#import "CPAReport.h"
#import "CPADetailViewController.h"

@interface CPADraftViewController ()

@end

@implementation CPADraftViewController

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    // return 0;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [appDelegate.reportArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"DraftCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //     cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //Get the object from the array.
    CPAReport *reportObj = [appDelegate.reportArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@, %@",reportObj.category, reportObj.time];
    
    // Set up the cell
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(dvController == nil)
		dvController = [[CPADetailViewController alloc] initWithNibName:@"DetailView" bundle:nil];

    CPAReport *reportObj = [appDelegate.reportArray objectAtIndex:indexPath.row];

    //We only load the data we initially want and keep on loading as we need.
//	[reportObj hydrateDetailViewData];
	dvController.passingReportObj = reportObj;

    
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

- (void)viewDidLoad
{

    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    appDelegate = (CPAAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.title = @"Draft";
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
        CPAReport *reportObj = [appDelegate.reportArray objectAtIndex:indexPath.row];
        [appDelegate removeReport:reportObj];
        
        //Delete the object from the table.
		[tabView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"EditingReportSegue"]){
        CPAReport *reportObj = [appDelegate.reportArray objectAtIndex:self.tableView.indexPathForSelectedRow.row];

        CPADetailViewController *detailViewController = segue.destinationViewController;
        detailViewController.passingReportObj = reportObj;
        //we need to figure out which task we are going to pass into
        //this will be determined by which role the user clicked in the table view
        // so we need to figure out the index of the row
    }
}




@end

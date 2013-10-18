//
//  GVMasterViewController.m
//  MasterDetailWithLogin
//
//  Created by Jonathan Engelsma on 9/6/13.
//  Copyright (c) 2013 Jonathan Engelsma. All rights reserved.
//

#import "GVMasterViewController.h"
#import "GVDetailViewController.h"
#import "GVLoginViewController.h"
#import "GVLoadingDetailViewController.h"
#import "GVAppDelegate.h"

@interface GVMasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation GVMasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
        self.detailViewManager = [[DetailViewManager alloc] init];
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;

    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        // store the "normal" detail view and its containing nav controller as props for future convenience.
        self.detailViewController = (GVDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
        self.detailNavCtrl = (UINavigationController *) [self.splitViewController.viewControllers lastObject];
        
        // tell the mgr about the detail, so buttons get added if needed.
        self.detailViewManager.detailViewController = self.detailViewController;
        
        // load up the alternate loading detail... we'll need it shortly!
        self.loadingDetailViewController = (GVLoadingDetailViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"LoadingDetailViewController"];
        [self.loadingDetailViewController view]; // force the outlets to be bound.
    }
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(![(GVAppDelegate*)[[UIApplication sharedApplication] delegate] authenticated])
    //if(!self.authenticated)
    {
        NSLog(@"not authenticated, put up login screen.");
        UIStoryboard *storyboard;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
        } else {
            storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
        }
        GVLoginViewController *vc =  (GVLoginViewController*)[storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        [vc setModalPresentationStyle:UIModalPresentationFullScreen];
        [self presentViewController:vc animated:NO completion:nil];
    }


}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    // on iPad, when we add our first item we want to force the detail page
    // to reload if necessary.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        if(_objects.count == 1) {
            self.detailViewController.detailItem = [_objects objectAtIndex:0];
            self.detailViewManager.detailViewController = self.detailViewController;
        }
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // on iPad, replace the loading detail view if we now have  data.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UIViewController *vc = [self.splitViewController.viewControllers lastObject];
        if((_objects.count > 0) && ([vc class] ==  [GVLoadingDetailViewController class])) {
            NSLog(@"We have data, replacing detail view with normal view.");
            self.detailViewManager.detailViewController = self.detailViewController;
        }
    }
    NSDate *object = _objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        // on iPad, after delete if we have no data, we switch back to our loading detail view.
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            if(_objects.count == 0 )
            {
                self.detailViewManager.detailViewController = self.loadingDetailViewController;
            }
        }
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSDate *object = _objects[indexPath.row];
        self.detailViewController.detailItem = object;
    }
}


@end

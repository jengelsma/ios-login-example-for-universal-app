//
//  GVDetailViewController.m
//  MasterDetailWithLogin
//
//  Created by Jonathan Engelsma on 9/6/13.
//  Copyright (c) 2013 Jonathan Engelsma. All rights reserved.
//

#import "GVDetailViewController.h"
#import "GVLoginViewController.h"
#import "GVLoadingDetailViewController.h"
#import "GVAppDelegate.h"

@interface GVDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation GVDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        // if we are in portrait mode and we are not authenticated, we need to invoke the login screen.
        // Note that this is necessary because in portrait mode, the master view's viewWillAppear will not
        // be called until its popover is displayed.
        if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation)
           && ![(GVAppDelegate*)[[UIApplication sharedApplication] delegate] authenticated])
        {
            // display login screen if we are not authenticated.
            NSLog(@"Not authenticated and in portrait, put up login screen.");
            GVLoginViewController *vc =  (GVLoginViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
            [vc setModalPresentationStyle:UIModalPresentationFullScreen];
            [self presentViewController:vc animated:NO completion:nil];
            
        } else if(self.detailItem == nil) {
            // display the alternate view if we have no data.
            NSLog(@"No data! loading detail view will appear as alternate until we have data.");
            DetailViewManager* dvm = (DetailViewManager*)self.splitViewController.delegate;
            dvm.detailViewController = dvm.loadingDetailViewController;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark SubstitutableDetailViewController

// -------------------------------------------------------------------------------
//	setNavigationPaneBarButtonItem:
//  Custom implementation for the navigationPaneBarButtonItem setter.
//  In addition to updating the _navigationPaneBarButtonItem ivar, it
//  reconfigures the toolbar to either show or hide the
//  navigationPaneBarButtonItem.
// -------------------------------------------------------------------------------
- (void)setNavigationPaneBarButtonItem:(UIBarButtonItem *)navigationPaneBarButtonItem
{
    [self.navigationItem setLeftItemsSupplementBackButton:YES];
    if (navigationPaneBarButtonItem != _navigationPaneBarButtonItem) {
        if (navigationPaneBarButtonItem) {
            [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObject:navigationPaneBarButtonItem]  animated:NO];
        } else {
            [self.navigationItem setLeftBarButtonItem:nil animated:NO];
        }
        _navigationPaneBarButtonItem = navigationPaneBarButtonItem;
    }
}



@end

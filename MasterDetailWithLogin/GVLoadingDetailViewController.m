
//
//  GVLoadingDetailViewController.m
//  MasterDetailWithLogin
//
//  Created by Jonathan Engelsma on 10/16/13.
//  Copyright (c) 2013 Jonathan Engelsma. All rights reserved.
//

#import "GVLoadingDetailViewController.h"

@interface GVLoadingDetailViewController ()

@end

@implementation GVLoadingDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.loadingIndicator startAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loadingDone:(id)sender {
    [self.loadingIndicator stopAnimating];
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
    // Note: this is view is not in a nav controller, but we've given it a toolbar. 
    if (navigationPaneBarButtonItem != _navigationPaneBarButtonItem) {
        if (navigationPaneBarButtonItem)
            [self.toolbar setItems:[NSArray arrayWithObject:navigationPaneBarButtonItem] animated:NO];
        else
            [self.toolbar setItems:nil animated:NO];
        
        _navigationPaneBarButtonItem = navigationPaneBarButtonItem;
    }
}

@end

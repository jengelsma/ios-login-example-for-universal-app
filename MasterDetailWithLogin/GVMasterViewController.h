//
//  GVMasterViewController.h
//  MasterDetailWithLogin
//
//  Created by Jonathan Engelsma on 9/6/13.
//  Copyright (c) 2013 Jonathan Engelsma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewManager.h"

@class GVLoadingDetailViewController;
@class GVDetailViewController;

@interface GVMasterViewController : UITableViewController
@property (strong, nonatomic) GVLoadingDetailViewController* loadingDetailViewController;
@property (strong, nonatomic) GVDetailViewController *detailViewController;
@property (strong, nonatomic) UINavigationController *detailNavCtrl;
@property (strong, nonatomic) DetailViewManager *detailViewManager;
@end

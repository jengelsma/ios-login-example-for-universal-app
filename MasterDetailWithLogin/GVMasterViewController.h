//
//  GVMasterViewController.h
//  MasterDetailWithLogin
//
//  Created by Jonathan Engelsma on 9/6/13.
//  Copyright (c) 2013 Jonathan Engelsma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GVDetailViewController;

@interface GVMasterViewController : UITableViewController

@property (strong, nonatomic) GVDetailViewController *detailViewController;

@end
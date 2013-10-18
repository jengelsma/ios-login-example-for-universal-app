//
//  GVDetailViewController.h
//  MasterDetailWithLogin
//
//  Created by Jonathan Engelsma on 9/6/13.
//  Copyright (c) 2013 Jonathan Engelsma. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "DetailViewManager.h"
@interface GVDetailViewController : UIViewController <SubstitutableDetailViewController>

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

/// SubstitutableDetailViewController
@property (nonatomic, retain) UIBarButtonItem *navigationPaneBarButtonItem;
@end

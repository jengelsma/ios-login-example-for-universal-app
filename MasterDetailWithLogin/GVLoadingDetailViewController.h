//
//  GVLoadingDetailViewController.h
//  MasterDetailWithLogin
//
//  Created by Jonathan Engelsma on 10/16/13.
//  Copyright (c) 2013 Jonathan Engelsma. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "DetailViewManager.h"
@interface GVLoadingDetailViewController : UIViewController<SubstitutableDetailViewController>
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (nonatomic, retain) UIBarButtonItem *navigationPaneBarButtonItem;
@end

//
//  GVMasterViewController.h
//  MasterDetailWithLogin
//
//  Created by Jonathan Engelsma on 9/6/13.
//  Copyright (c) 2013 Jonathan Engelsma. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MasterViewDelegate <NSObject>
@required
- (void) masterViewPopOverWillAppear;
@end

@class GVDetailViewController;

@interface GVMasterViewController : UITableViewController<MasterViewDelegate>
@property (strong, nonatomic) GVDetailViewController *detailViewController;
@property (nonatomic) BOOL authenticated;
-(void) masterViewPopOverWillAppear;
@end

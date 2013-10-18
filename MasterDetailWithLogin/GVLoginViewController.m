//
//  GVLoginViewController.m
//  MasterDetailWithLogin
//
//  Created by Jonathan Engelsma on 9/6/13.
//  Copyright (c) 2013 Jonathan Engelsma. All rights reserved.
//

#import "GVLoginViewController.h"
#import "GVAppDelegate.h"

@interface GVLoginViewController ()

@end

@implementation GVLoginViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginPressed:(id)sender {
    // once login button is pressed, we update our global authentication flag. 
    GVAppDelegate *ad = (GVAppDelegate*)[[UIApplication sharedApplication] delegate];
    ad.authenticated = YES;
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

@end

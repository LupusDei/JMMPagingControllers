//
//  JMMViewController.m
//  PagingControllers
//
//  Created by Justin Martin on 10/21/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import "JMMViewController.h"
#import "JMMPagingController.h"
#import "JMMViewControllerBlue.h"
#import "JMMViewControllerGreen.h"
#import "JMMViewControllerRed.h"
@interface JMMViewController ()

@end

@implementation JMMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)doWork:(id)sender {
    JMMPagingController *pager = [JMMPagingController pagingControllerWithControllerClasses:@[[JMMViewControllerBlue class],[JMMViewControllerRed class], [JMMViewControllerGreen class]]];
    
    [self.view.window setRootViewController:pager];
}

@end

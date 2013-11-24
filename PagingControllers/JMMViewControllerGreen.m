//
//  JMMViewControllerGreen.m
//  PagingControllers
//
//  Created by Justin Martin on 10/24/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import "JMMViewControllerGreen.h"

@interface JMMViewControllerGreen ()

@end

@implementation JMMViewControllerGreen


+(JMMViewControllerGreen *) prepareControllerWithPager:(JMMPagingController *)pager {
    NSLog(@"PrepareController GREEN");
    return [[JMMViewControllerGreen alloc] init];
}

-(void) controllerWillAppear {
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
//    [self.view withHeight:320];
//    [self.view withY:100];
}

-(void) controllerWillDisappear {
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	NSLog(@"GREEN -- viewDidLoad");
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(100, 320, 120, 20)];
    view.text = @"Helo ALL THERE";
    [self.view addSubview:view];
    NSLog(@"Blue -- viewDidAppear");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

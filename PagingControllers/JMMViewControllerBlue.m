//
//  JMMViewControllerBlue.m
//  PagingControllers
//
//  Created by Justin Martin on 10/22/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import "JMMViewControllerBlue.h"

@interface JMMViewControllerBlue ()

@end

@implementation JMMViewControllerBlue

+(JMMViewControllerBlue *) prepareControllerWithPager:(JMMPagingController *)pager {
    return [[JMMViewControllerBlue alloc] init];
}

-(void) controllerWillAppear {
    [self.view setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
//    [self.view withHeight:320];
    [self.view withY:0];
}

-(void) controllerWillDisappear {
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	NSLog(@"Blue -- viewDidLoad");
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(100, 250, 120, 20)];
    view.text = @"Helo workd";
    [self.view addSubview:view];
    NSLog(@"Blue -- viewDidAppear");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

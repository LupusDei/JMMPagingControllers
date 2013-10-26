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


+(JMMViewControllerGreen *) prepareController {
    NSLog(@"PrepareController GREEN");
    return [[JMMViewControllerGreen alloc] init];
}

-(void) controllerWillAppear {
    [self.view setBackgroundColor:[UIColor greenColor]];
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
    NSLog(@"Blue -- viewDidAppear");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

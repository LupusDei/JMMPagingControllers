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

+(JMMViewControllerBlue *) prepareController {
    return [[JMMViewControllerBlue alloc] init];
}

-(void) controllerWillAppear {
    [self.view setBackgroundColor:[UIColor blueColor]];
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
    NSLog(@"Blue -- viewDidAppear");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  JMMViewControllerRed.m
//  PagingControllers
//
//  Created by Justin Martin on 10/22/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import "JMMViewControllerRed.h"

@interface JMMViewControllerRed ()

@end

@implementation JMMViewControllerRed

+(JMMViewControllerRed *) prepareController {
    return [[JMMViewControllerRed alloc] init];
}

-(void) controllerWillAppear {
    [self.view setBackgroundColor:[UIColor redColor]];
    [self.view withHeight:320];
    [self.view withY:50];
}

-(void) controllerWillDisappear {
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	NSLog(@"Red -- viewDidLoad");
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"Red -- viewDidAppear");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

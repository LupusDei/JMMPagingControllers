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

+(JMMViewControllerRed *) prepareControllerWithPager:(JMMPagingController *)pager {
    return [[JMMViewControllerRed alloc] init];
}

-(void) controllerWillAppear {
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.98 alpha:1]];
//    [self.view withHeight:320];
//    [self.view withY:50];
    NSLog(@"Red -- controllerWillAppear");
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
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(80, 50, 120, 25)];
    [button setTitle:@"A Button" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button];
    NSLog(@"Button: %@", button);
}

-(void) buttonPressed {
    NSLog(@"Button Pressed");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

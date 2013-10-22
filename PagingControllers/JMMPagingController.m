//
//  JMMPagingController.m
//  PagingControllers
//
//  Created by Justin Martin on 10/21/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import "JMMPagingController.h"
#import "JMMPagingControllerView.h"

@interface JMMPagingController ()
@property (nonatomic, strong) NSMutableArray *pagedControllersClasses;
@property (strong, nonatomic) NSMutableArray *pagedControllers;
@end

@implementation JMMPagingController {
	int currentPage;
    JMMPagingControllerView *overlayView;
}

+(JMMPagingController *) pagingControllerWithFirstControllerClass:(Class)first
                                         andSecondControllerClass:(Class)second {
    JMMPagingController *jmm = [[JMMPagingController alloc] init];
    [jmm.pagedControllersClasses addObject:first];
    [jmm.pagedControllersClasses addObject:second];
    return jmm;
}

- (id)init {
    self = [super init];
    if (self) {
        self.pagedControllersClasses = [NSMutableArray array];
        self.pagedControllers = [NSMutableArray array];
		currentPage = 0;
    }
    return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
    [self.view setBackgroundColor:[UIColor yellowColor]];
    overlayView = [[JMMPagingControllerView alloc] initWithPagingController:self];
    [self.view addSubview:overlayView];
    [self addControllerAtIndex:0];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self addControllerAtIndex:1];
}

-(void) addControllerAtIndex:(int)index {
    Class controller = [self.pagedControllersClasses objectAtIndex:index];
	UIViewController<PagedController> *page= [((id<PagedController>) controller) prepareController];
    [page controllerWillAppear];
    float xPos = self.view.width * (index - currentPage);
    [page.view withX:xPos];
    [self.view addSubview:page.view];
    [self addChildViewController:page];
    [self.pagedControllers addObject:page];
    [self.view bringSubviewToFront:overlayView];
}

-(UIView *) currentForegroundView {
    return ((UIViewController *)self.pagedControllers[currentPage]).view;
}

-(UIView *) nextForegroundView {
    if (currentPage == [self.pagedControllers count] - 1)
        return nil;
    return ((UIViewController *)self.pagedControllers[currentPage + 1]).view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

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

+(JMMPagingController *) pagingControllerWithControllerClasses:(NSArray *)controllers {
    JMMPagingController *jmm = [[JMMPagingController alloc] init];
    [jmm.pagedControllersClasses addObjectsFromArray:controllers];
    return jmm;
}

- (id)init {
    self = [super init];
    if (self) {
        self.pagedControllersClasses = [NSMutableArray array];
        self.pagedControllers = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
    currentPage = 0;
    [self.view setBackgroundColor:[UIColor yellowColor]];
    overlayView = [[JMMPagingControllerView alloc] initWithPagingController:self];
    [self.view addSubview:overlayView];
    [self addControllerAtIndex:0];
    [overlayView enablePaging];
    [overlayView disableBackwardPaging];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self addControllerAtIndex:1];
}

-(void) addControllerAtIndex:(int)index {
	NSLog(@"addCon at index:%d", index);
    UIViewController<PagedController> *page;
    if ([self hasAlreadyAddedControllerAtIndex:index]) {
        NSLog(@"hasAlreadyAddedCOnroller :%d", index);
        page = [self.pagedControllers objectAtIndex:index];
        [page controllerWillAppear];
        return;
    }
    Class controller = [self.pagedControllersClasses objectAtIndex:index];
	page = [((id<PagedController>) controller) prepareControllerWithPager:self];
    [page controllerWillAppear];
    float xPos = self.view.width * (index - currentPage);
    [page.view withX:xPos];
    [self.view addSubview:page.view];
    [self addChildViewController:page];
    [self.pagedControllers addObject:page];
//    [self.view bringSubviewToFront:overlayView];
}

-(void) skipToNextPage {
    if (![self isAtLastPage])
        [overlayView springToNextView];
    
}
-(void) skipToPreviousPage {
    if (![self isAtFirstPage])
        [overlayView springToPreviousView];
}

-(UIViewController *)currentForegroundController {
    return (UIViewController *)self.pagedControllers[currentPage];
}

-(UIView *) currentForegroundView {
    return [self currentForegroundController].view;
}

-(UIView *) nextForegroundView {
    if ([self isAtLastPage])
        return nil;
    return ((UIViewController *)self.pagedControllers[currentPage + 1]).view;
}

-(UIView *) previousForegroundView {
    if ([self isAtFirstPage])
        return nil;
    return ((UIViewController *)self.pagedControllers[currentPage - 1]).view;
}

-(void) pageForward {
    currentPage++;
    [self page:@"pageForward"];

    [overlayView enablePaging];
    if ([self isAtLastPage])
        [overlayView disableForwardPaging];
    else
        [self addControllerAtIndex:currentPage + 1];
}
-(void) pageBackward {
    currentPage--;
    [self page:@"pageBack"];

    [overlayView enablePaging];
    if ([self isAtFirstPage])
        [overlayView disableBackwardPaging];
}

#pragma mark Internal Helpers

-(void) page:(NSString *)thing {
    NSLog(@"%@    page: %d",thing, currentPage);
}

-(BOOL) isAtFirstPage {
    return currentPage == 0;
}

-(BOOL) isAtLastPage {
    return currentPage == [self.pagedControllersClasses count] - 1;
}

-(BOOL) hasAlreadyAddedControllerAtIndex:(int)index {
	return index < [self.pagedControllers count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

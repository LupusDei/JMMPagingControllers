//
//  JMMPagingController.m
//  PagingControllers
//
//  Created by Justin Martin on 10/21/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import "JMMPagingController.h"

#define DefaultDragTriggerDistance 25
#define DefaultDragPagingDistance 140

#define StandardWidth 320

@interface JMMPagingController ()
@property (nonatomic, strong) NSMutableArray *pagedControllersClasses;
@property (strong, nonatomic) NSMutableArray *pagedControllers;
@end

@implementation JMMPagingController {
	int currentPage;
    BOOL canPageForward;
    BOOL canPageBackward;
    BOOL triggerWasReached;
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
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self enablePaging];
    [self disableBackwardPaging];
    [self addControllerAtIndex:0];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self addControllerAtIndex:1];
}

-(void) addControllerAtIndex:(int)index {
    UIViewController<PagedController> *page;
    if ([self hasAlreadyAddedControllerAtIndex:index]) {
        page = [self.pagedControllers objectAtIndex:index];
        return;
    }
    Class controller = [self.pagedControllersClasses objectAtIndex:index];
	page = [((id<PagedController>) controller) prepareControllerWithPager:self];
    float xPos = self.view.width * (index - currentPage);
    [page.view withX:xPos];
    [self.view addSubview:page.view];
    [self addChildViewController:page];
    [self.pagedControllers addObject:page];
    [self addPanGestureRecognizerToView:page.view];
}

-(void) addPanGestureRecognizerToView:(UIView *)view {
    UIPanGestureRecognizer *panner = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(startedPanning:)];
    [view addGestureRecognizer:panner];
}

-(void) skipToNextPage {
    if (![self isAtLastPage])
        [self springToNextView];
    
}
-(void) skipToPreviousPage {
    if (![self isAtFirstPage])
        [self springToPreviousView];
}

-(UIViewController<PagedController> *)currentForegroundController {
    return (UIViewController<PagedController> *)self.pagedControllers[currentPage];
}

-(UIView *) currentForegroundView {
    return [self currentForegroundController].view;
}

-(UIViewController<PagedController> *)nextForegroundController {
    if ([self isAtLastPage])
        return nil;
    return (UIViewController<PagedController> *)self.pagedControllers[currentPage + 1];
}

-(UIView *) nextForegroundView {
    if ([self isAtLastPage])
        return nil;
    return [self nextForegroundController].view;
}

-(UIViewController<PagedController> *)previousForegroundController {
    if ([self isAtFirstPage])
        return nil;
    return (UIViewController<PagedController> *)self.pagedControllers[currentPage - 1];
}

-(UIView *) previousForegroundView {
    if ([self isAtFirstPage])
        return nil;
    return [self previousForegroundController].view;
}

-(void) pageForward {
    currentPage++;
    
    [self enablePaging];
    if ([self isAtLastPage])
        [self disableForwardPaging];
    else
        [self addControllerAtIndex:currentPage + 1];
}
-(void) pageBackward {
    currentPage--;
    
    [self enablePaging];
    if ([self isAtFirstPage])
        [self disableBackwardPaging];
}

#pragma mark Panning
-(void) enablePaging {
    NSLog(@"Enable Paging");
    canPageForward = YES;
    canPageBackward = YES;
}
-(void) disableForwardPaging {
    NSLog(@"Disable forward paging");
    canPageForward = NO;
}
-(void) disableBackwardPaging {
    canPageBackward = NO;
}

-(void) startedPanning:(UIPanGestureRecognizer *)panner {
	CGPoint newPoint = [panner translationInView:self.view];
    if (panner.state == UIGestureRecognizerStateEnded) {
        [self springAppropriatelyWithFinalX:newPoint.x];
        triggerWasReached = NO;
    }
    else {
        CGFloat x = newPoint.x;
        if (![self hasReachedTriggerPoint:x]) return;
        
        if ([self isPanningBackward:x]) {
            if (!canPageBackward) return;
            if (!triggerWasReached) {
                @try {
                    [self.previousForegroundController controllerWillAppear];
                    [self.currentForegroundController controllerDidBegingPagingAway];
                } @catch (NSException *exception) {}
            }
            x = x - DefaultDragTriggerDistance;
        }
        else {
            if (!canPageForward) return;
            if (!triggerWasReached) {
                @try {
                    [self.nextForegroundController controllerWillAppear];
                    [self.currentForegroundController controllerDidBegingPagingAway];
                } @catch (NSException *exception) {}
            }
            x = x + DefaultDragTriggerDistance;
        }
        triggerWasReached = YES;
        [self panAssociatedViewsWithNewX:x];
    }
}
-(BOOL) isPanningBackward:(CGFloat)x {return x > 0;}

-(void) panAssociatedViewsWithNewX:(CGFloat)x {
    [self.previousForegroundView withX:-StandardWidth + x];
    [self.currentForegroundView withX:x];
    [self.nextForegroundView withX:StandardWidth + x];
}

-(BOOL) hasReachedTriggerPoint:(CGFloat)x {
    return (x < 0 && -x > DefaultDragTriggerDistance) || (x > 0 && x > DefaultDragTriggerDistance);
}

-(void) springAppropriatelyWithFinalX:(CGFloat)x {
    if (-x > DefaultDragPagingDistance && canPageForward)
        [self springToNextView];
    else if (x > DefaultDragPagingDistance && canPageBackward)
        [self springToPreviousView];
    else
        [self springBackToCurrentView];
}

-(void) springToNextView {
    @try {
        [self.currentForegroundController controllerWillDisappear];
    } @catch (NSException *exception) {}
	[UIView animateWithDuration:0.15
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [[self currentForegroundView] withX: -StandardWidth];
                         [[self nextForegroundView] withX:0];
                         [[self previousForegroundView] withX:-StandardWidth];
                     }
                     completion:^(BOOL finished){
                         @try {
                             [self.currentForegroundController controllerDidDisappear];
                         } @catch (NSException *exception) {}
                         @try {[[self nextForegroundController] controllerDidAppear];}
                         @catch (NSException *exception) {}
                         [self pageForward];
                     }];
}

-(void)springBackToCurrentView {
	[UIView animateWithDuration:0.15
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [[self currentForegroundView] withX:0];
                         [[self nextForegroundView] withX:StandardWidth];
                         [[self previousForegroundView] withX:-StandardWidth];
                     }
                     completion:^(BOOL finished){
                     }];
}

-(void)springToPreviousView {
    @try {
        [self.currentForegroundController controllerWillDisappear];
    } @catch (NSException *exception) {}
	[UIView animateWithDuration:0.15
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [[self currentForegroundView] withX:StandardWidth];
                         [[self nextForegroundView] withX:StandardWidth];
                         [[self previousForegroundView] withX:0];
                     }
                     completion:^(BOOL finished){
                         @try {
                             [self.currentForegroundController controllerDidDisappear];
                         } @catch (NSException *exception) {}
                         @try {[[self previousForegroundController] controllerDidAppear];}
                         @catch (NSException *exception) {}
                         [self pageBackward];
                     }];
}


#pragma mark Internal Helpers

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

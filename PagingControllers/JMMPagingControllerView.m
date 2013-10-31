//
//  JMMPagingControllerView.m
//  PagingControllers
//
//  Created by Justin Martin on 10/22/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import "JMMPagingControllerView.h"
#import "JMMPagingController.h"

#define DefaultDragTriggerDistance 25
#define DefaultDragPagingDistance 140

@interface JMMPagingControllerView ()

@end

@implementation JMMPagingControllerView {
    JMMPagingController *pager;
    CGPoint _firstTouch;
	CGFloat _firstX;
    BOOL canPageForward;
    BOOL canPageBackward;
}

-(id) initWithPagingController:(JMMPagingController *)controller {
    self = [super initWithFrame:controller.view.frame];
    [self setBackgroundColor:[UIColor clearColor]];
    self.exclusiveTouch = NO;
    pager = controller;
    return self;
}

-(void) enablePaging {
    canPageForward = YES;
    canPageBackward = YES;
}
-(void) disableForwardPaging {
    canPageForward = NO;
}
-(void) disableBackwardPaging {
    canPageBackward = NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	_firstTouch = [touch locationInView:self];
    
    [self passBeganTouches:touches toCurrentForegroundViewForEvent:event];
}

-(void) passBeganTouches:(NSSet *)touches toCurrentForegroundViewForEvent:(UIEvent *)event {
    CGPoint otherPoint = [[touches anyObject] locationInView:[pager currentForegroundView]];
    UIView *currentHitView = [[pager currentForegroundView] hitTest:otherPoint withEvent:event];
    NSLog(@"Began: point:%@ secondView: %@\nnextResp:%@", NSStringFromCGPoint(otherPoint), currentHitView, self.nextResponder);
    [currentHitView touchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self passMovedTouches:touches toCurrentForegroundViewForEvent:event];
    
	UITouch *touch = [touches anyObject];
	CGPoint touchPoint = [touch locationInView:self];
	UIView *currentView = [pager currentForegroundView];
	CGFloat xPos = 0;
    
    xPos = touchPoint.x - _firstTouch.x;
    if (![self hasReachedTriggerPoint:xPos])
        return;
    if (xPos < 0 && !canPageForward)
        return;
	if (xPos > 0 && !canPageBackward)
        return;
    
    [[pager previousForegroundView] withX:xPos - currentView.width];
    [currentView withX:xPos];
    [[pager nextForegroundView] withX:xPos + currentView.width];
}

-(void) passMovedTouches:(NSSet *)touches toCurrentForegroundViewForEvent:(UIEvent *)event {
    CGPoint otherPoint = [[touches anyObject] locationInView:[pager currentForegroundView]];
    UIView *currentHitView = [[pager currentForegroundView] hitTest:otherPoint withEvent:event];
    NSLog(@"Moved: point:%@ secondView: %@", NSStringFromCGPoint(otherPoint), currentHitView);
    [currentHitView touchesMoved:touches withEvent:event];
}

-(BOOL) hasReachedTriggerPoint:(float)x {
    return (x < 0 && -x > DefaultDragTriggerDistance) || (x > 0 && x > DefaultDragTriggerDistance);
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self passEndedTouches:touches toCurrentForegroundViewForEvent:event];
	UITouch *touch = [touches anyObject];
	CGPoint touchPoint = [touch locationInView:self];
	CGFloat xPos = touchPoint.x - _firstTouch.x;
    
	if ((-xPos) > DefaultDragPagingDistance && canPageForward)
		[self springToNextView];
	else if (xPos > DefaultDragPagingDistance && canPageBackward)
        [self springToPreviousView];
    else
		[self springBackToCurrentView];
}

-(void) passEndedTouches:(NSSet *)touches toCurrentForegroundViewForEvent:(UIEvent *)event {
    CGPoint otherPoint = [[touches anyObject] locationInView:[pager currentForegroundView]];
    UIView *currentHitView = [[pager currentForegroundView] hitTest:otherPoint withEvent:event];
    NSLog(@"Ended: point:%@ secondView: %@", NSStringFromCGPoint(otherPoint), currentHitView);
    [currentHitView touchesEnded:touches withEvent:event];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	[self springBackToCurrentView];
}

-(void) springToNextView {
	[UIView animateWithDuration:0.15
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [[pager currentForegroundView] withX: -self.width];
                         [[pager nextForegroundView] withX:0];
                         [[pager previousForegroundView] withX:-self.width];
                     }
                     completion:^(BOOL finished){
                         [pager pageForward];
                     }];
}

-(void)springBackToCurrentView {
	[UIView animateWithDuration:0.15
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [[pager currentForegroundView] withX:0];
                         [[pager nextForegroundView] withX:self.width];
                         [[pager previousForegroundView] withX:-self.width];
                     }
                     completion:^(BOOL finished){
                     }];
}

-(void)springToPreviousView {
	[UIView animateWithDuration:0.15
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [[pager currentForegroundView] withX:self.width];
                         [[pager nextForegroundView] withX:self.width];
                         [[pager previousForegroundView] withX:0];
                     }
                     completion:^(BOOL finished){
                         [pager pageBackward];
                     }];
}


//-(UIResponder *) nextResponder {
//    NSLog(@"next responder");
//    return [pager currentForegroundController];
//}

@end

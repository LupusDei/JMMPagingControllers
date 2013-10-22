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
}

-(id) initWithPagingController:(JMMPagingController *)controller {
    self = [super initWithFrame:controller.view.frame];
    [self setBackgroundColor:[UIColor clearColor]];
    self.exclusiveTouch = NO;
    pager = controller;
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	_firstTouch = [touch locationInView:self];
    NSLog(@"Touch bega - %@", NSStringFromCGPoint(_firstTouch));
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint touchPoint = [touch locationInView:self];
	UIView *currentView = [pager currentForegroundView];
    UIView *nextView = [pager nextForegroundView];
	CGFloat xPos = 0;
	
    if (touchPoint.x < _firstTouch.x) {
        xPos = touchPoint.x - _firstTouch.x;
    }
    [currentView withX:xPos];
    [nextView withX:xPos + currentView.width];        
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint touchPoint = [touch locationInView:self];
	CGFloat xPos = touchPoint.x - _firstTouch.x;
    
	if (abs(xPos) > DefaultDragPagingDistance)
		[self springToNextView];
	else if ([pager currentForegroundView].x > 0)
		[self springBackToCurrentView];
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
                     }
                     completion:^(BOOL finished){
                     }];
}

-(void)springBackToCurrentView {
	[UIView animateWithDuration:0.15
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [[pager currentForegroundView] withX:0];
                         [[pager nextForegroundView] withX:self.width];
                     }
                     completion:^(BOOL finished){
                     }];
}



@end

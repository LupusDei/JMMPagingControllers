//
//  JMMPagingController.h
//  PagingControllers
//
//  Created by Justin Martin on 10/21/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JMMPagingController;

@protocol PagedController
+(UIViewController<PagedController> *) prepareControllerWithPager:(JMMPagingController *)pager;

@optional
-(void) controllerDidBegingPagingAway;
-(void) controllerWillAppear;
-(void) controllerDidAppear;
-(void) controllerWillDisappear;
-(void) controllerDidDisappear;

-(void) attemptingToSwipeToNoWhere;
-(void) finishedSwipingToNowhere;
@end

@interface JMMPagingController : UIViewController

+(JMMPagingController *) pagingControllerWithFirstControllerClass:(Class)first andSecondControllerClass:(Class)second;
+(JMMPagingController *) pagingControllerWithControllerClasses:(NSArray *)controllers;

-(UIViewController<PagedController> *)currentForegroundController;
-(UIView *)currentForegroundView;
-(UIView *) nextForegroundView;
-(UIView *) previousForegroundView;


-(void) disableForwardPaging;
-(void) disableBackwardPaging;
-(void) enablePaging;

-(void) skipToNextPage;
-(void) skipToPreviousPage;

@end

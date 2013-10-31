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
-(void) controllerWillAppear;
-(void) controllerWillDisappear;
@end

@interface JMMPagingController : UIViewController

+(JMMPagingController *) pagingControllerWithFirstControllerClass:(Class)first andSecondControllerClass:(Class)second;
+(JMMPagingController *) pagingControllerWithControllerClasses:(NSArray *)controllers;

-(UIViewController *)currentForegroundController;
-(UIView *)currentForegroundView;
-(UIView *) nextForegroundView;
-(UIView *) previousForegroundView;

-(void) skipToNextPage;
-(void) skipToPreviousPage;


//These are for the PagingControllerView only
-(void) pageForward;
-(void) pageBackward;
@end

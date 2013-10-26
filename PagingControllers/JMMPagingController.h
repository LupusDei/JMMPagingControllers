//
//  JMMPagingController.h
//  PagingControllers
//
//  Created by Justin Martin on 10/21/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PagedController
+(UIViewController<PagedController> *) prepareController;
-(void) controllerWillAppear;
-(void) controllerWillDisappear;
@end

@interface JMMPagingController : UIViewController

+(JMMPagingController *) pagingControllerWithFirstControllerClass:(Class)first andSecondControllerClass:(Class)second;
+(JMMPagingController *) pagingControllerWithControllerClasses:(NSArray *)controllers;

-(UIView *)currentForegroundView;
-(UIView *) nextForegroundView;
-(UIView *) previousForegroundView;

-(void) pageForward;
-(void) pageBackward;
@end

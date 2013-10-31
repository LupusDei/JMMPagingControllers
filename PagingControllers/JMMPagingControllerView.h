//
//  JMMPagingControllerView.h
//  PagingControllers
//
//  Created by Justin Martin on 10/22/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JMMPagingController;

@interface JMMPagingControllerView : UIView

-(id) initWithPagingController:(JMMPagingController *)controller;

-(void) enablePaging;
-(void) disableForwardPaging;
-(void) disableBackwardPaging;
-(void) springToNextView;
-(void) springToPreviousView;

@end

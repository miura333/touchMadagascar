//
//  ARPLNavigationCtrl.h
//  arappli3
//
//  Created by Tester on 12/02/13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARPLNavigationSubViewBase.h"
#import "ARPLSubViewDelegate.h"
#import "ARPLSubViewBase.h"

@class ARPLNavigationSubViewBase;

typedef enum {
	kAnimationTypeSlideInOut = 1,
	kAnimationTypeDissolve = 2,
    kAnimationTypeSlideUpDown = 3
} ARPLNavAnimationType;

@interface ARPLNavigationCtrl : ARPLSubViewBase {
    BOOL _animating;
    int _tmp_toIndex;
}
@property NSMutableArray *viewControllers;
@property (weak) UIViewController *parent;

- (void)initializeView:(ARPLNavigationSubViewBase *)vc orientation:(UIInterfaceOrientation)io;
- (void)pushView:(ARPLNavigationSubViewBase *)vc animationType:(ARPLNavAnimationType)at;
- (void)popCurrentView:(ARPLNavAnimationType)at;
- (int)getCurrentPageIndex;

- (void)popViewToIndex:(ARPLNavAnimationType)at toIndex:(int)toIndex;

@end

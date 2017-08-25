//
//  ARPLNavigationSubViewBase.h
//  arappli3
//
//  Created by Tester on 12/02/13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARPLNavigationCtrl.h"
#import "ARPLNotificationReceiverView.h"

@class ARPLNavigationCtrl;

@interface ARPLNavigationSubViewBase : ARPLNotificationReceiverView {
    UIToolbar *_toolBar;
    UIImageView *_bg_toolBar;
    
    BOOL _isEditing;
}
@property (weak) ARPLNavigationCtrl *_nav;

- (void)updateUILayout:(UIInterfaceOrientation)io;
- (void)popAnimationDidEnd;
- (void)pushAnimationDidEnd;
- (void)rotateUI:(UIInterfaceOrientation)io;
- (void)dissolveAnimationCurrentViewHidden;


@end

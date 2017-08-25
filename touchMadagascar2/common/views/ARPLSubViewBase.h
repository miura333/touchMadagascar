//
//  ARPDSubViewBase.h
//  arappli3
//
//  Created by Tester on 12/02/10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARPLSubViewDelegate.h"
#import "ARPLNotificationReceiverView.h"

@interface ARPLSubViewBase : ARPLNotificationReceiverView

@property (weak) id<ARPLSubViewDelegate> tmp_delegate;
@property (readwrite) UIInterfaceOrientation io;

- (void)updateUILayout:(UIInterfaceOrientation)io;

@end

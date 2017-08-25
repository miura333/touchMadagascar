//
//  ARPLNotificationReceiverView.m
//  arappli3
//
//  Created by マサカズ ミウラ on 12/07/26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ARPLNotificationReceiverView.h"
#import "DefineAll.h"

@implementation ARPLNotificationReceiverView

- (void)startObserving {
    // Start observing
    if (!_observing) {
        NSNotificationCenter *center;
        center = [NSNotificationCenter defaultCenter];
        [center addObserver:self
                   selector:@selector(keyboardWillShow:)
                       name:UIKeyboardWillShowNotification
                     object:nil];
        [center addObserver:self
                   selector:@selector(keybaordWillHide:)
                       name:UIKeyboardWillHideNotification
                     object:nil];
        
        _observing = YES;
    }
}

- (void)stopObserving {
    // Stop observing
    if (_observing) {
        NSNotificationCenter *center;
        center = [NSNotificationCenter defaultCenter];
        [center removeObserver:self
                          name:UIKeyboardWillShowNotification
                        object:nil];
        [center removeObserver:self
                          name:UIKeyboardWillHideNotification
                        object:nil];
        
        _observing = NO;
    }
}

- (void)startObserving_inactive_active {
    // Start observing
    if (!_observing_inactive_active) {
        NSNotificationCenter *center;
        center = [NSNotificationCenter defaultCenter];
        [center addObserver:self
                   selector:@selector(applicationBecomeInactive:)
                       name:ARPL_NOTIFICATION_DIDENTERBACKGROUND
                     object:nil];
        [center addObserver:self
                   selector:@selector(applicationBecomeActive:)
                       name:ARPL_NOTIFICATION_WILLENTERFOREGROUND
                     object:nil];
        
        _observing_inactive_active = YES;
    }
}

- (void)stopObserving_inactive_active {
    // Stop observing
    if (_observing_inactive_active) {
        NSNotificationCenter *center;
        center = [NSNotificationCenter defaultCenter];
        [center removeObserver:self
                          name:ARPL_NOTIFICATION_DIDENTERBACKGROUND
                        object:nil];
        [center removeObserver:self
                          name:ARPL_NOTIFICATION_WILLENTERFOREGROUND
                        object:nil];
        
        _observing_inactive_active = NO;
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _observing = NO;
        _observing_inactive_active = NO;        
    }
    return self;
}

- (void)dealloc {
    [self stopObserving];
    [self stopObserving_inactive_active];
}

#pragma mark keyboard norification
- (void)keyboardWillShow:(NSNotification*)notification
{
    //here, do nothing
}

- (void)keybaordWillHide:(NSNotification*)notification
{
    //here, do nothing
}

- (void)applicationBecomeInactive:(NSNotification*)notification
{
    //here, do nothing
}

- (void)applicationBecomeActive:(NSNotification*)notification
{
    //here, do nothing
}

@end

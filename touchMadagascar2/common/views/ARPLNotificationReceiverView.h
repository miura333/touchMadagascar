//
//  ARPLNotificationReceiverView.h
//  arappli3
//
//  Created by マサカズ ミウラ on 12/07/26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARPLNotificationReceiverView : UIView {
    BOOL _observing;
    BOOL _observing_inactive_active;
}

- (void)startObserving;
- (void)stopObserving;

- (void)startObserving_inactive_active;
- (void)stopObserving_inactive_active;

@end

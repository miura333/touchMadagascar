//
//  ARPDPopoverSubViewBaseDelegate.h
//  arappliPad
//
//  Created by Tester on 11/06/07.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ARPLURSubViewBaseDelegate <NSObject>
- (void)urSubViewDelegate_closeButtonTapped;
@optional
- (void)urSubViewDelegate_okButtonTapped:(int)index;
- (void)urSubViewDelegate_date_okButtonTapped:(NSDate *)date;
- (void)urSubViewDelegate_account_okButtonTapped:(NSString *)username passwd:(NSString *)passwd;
@end

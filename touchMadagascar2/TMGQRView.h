//
//  TMGQRView.h
//  touchMadagascar2
//
//  Created by miura on 2015/03/05.
//  Copyright (c) 2015年 miura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARPLNavigationSubViewBase.h"

@interface TMGQRView : ARPLNavigationSubViewBase {
    int _country_code;
}

- (void)initializeView:(int)num;

@end

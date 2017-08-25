//
//  TMG321View.h
//  touchMadagascar2
//
//  Created by miura on 2015/03/05.
//  Copyright (c) 2015年 miura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARPLNavigationSubViewBase.h"

@interface TMG321View : ARPLNavigationSubViewBase {
    int _cnt;
}

@property (strong) UILabel *label_1;
@property (strong) UILabel *label_2;
@property (strong) UILabel *label_3;

- (void)startCountDown;

@end

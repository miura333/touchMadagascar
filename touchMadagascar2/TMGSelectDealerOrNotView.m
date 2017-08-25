//
//  TMGSelectDealerOrNotView.m
//  touchMadagascar2
//
//  Created by miura on 2015/03/05.
//  Copyright (c) 2015年 miura. All rights reserved.
//

#import "TMGSelectDealerOrNotView.h"
#import "AppUtil.h"
#import "DefineAll.h"
#import "TMGSelectLevelView.h"
#import "TMGQRScanView.h"

@implementation TMGSelectDealerOrNotView

- (void)dealerButtonTapped:(id)sender {
    int width = 0, height = 0;
    [AppUtil getSubViewDimension:&width height:&height];
    
    TMGSelectLevelView *dealerView = [[TMGSelectLevelView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [self._nav pushView:dealerView animationType:kAnimationTypeSlideInOut];
    [dealerView initializeView];
    
}

- (void)nonDealerButtonTapped:(id)sender {
    int width = 0, height = 0;
    [AppUtil getSubViewDimension:&width height:&height];
    
    TMGQRScanView *scanView = [[TMGQRScanView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [self._nav pushView:scanView animationType:kAnimationTypeSlideInOut];
    [scanView initializeView];
}

- (void)backButtonTapped:(id)sender {
    [self._nav popCurrentView:kAnimationTypeSlideInOut];
}

- (void)initializeView {
    if([self._nav getCurrentPageIndex] > 0) {
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button1 setFrame:CGRectMake(0, 20, 44, 44)];
        [button1 addTarget:self action:@selector(backButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [button1 setImage:[UIImage imageNamed:@"00-icon_back_normal"] forState:UIControlStateNormal];
        [button1 setImage:[UIImage imageNamed:@"00-icon_back_tap"] forState:UIControlStateHighlighted];
        [self addSubview:button1];
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];
        
        int width = 0, height = 0;
        [AppUtil getSubViewDimension:&width height:&height];
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button1 setFrame:CGRectMake(width/2 - 150/2, 100, 150, 75)];
        [button1.layer setCornerRadius:10];
        [button1 setBackgroundColor:[UIColor whiteColor]];
        [button1.layer setBorderColor:TMG_COLOR_GRAY.CGColor];
        [button1.layer setBorderWidth:2];
        [button1 setTitle:@"Dealer" forState:UIControlStateNormal];
        [button1 setTitleColor:TMG_COLOR_GRAY forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(dealerButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button1];
        
        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button2 setFrame:CGRectMake(width/2 - 150/2, 200, 150, 75)];
        [button2.layer setCornerRadius:10];
        [button2 setBackgroundColor:[UIColor whiteColor]];
        [button2.layer setBorderColor:TMG_COLOR_GRAY.CGColor];
        [button2.layer setBorderWidth:2];
        [button2 setTitle:@"Non-dealer" forState:UIControlStateNormal];
        [button2 setTitleColor:TMG_COLOR_GRAY forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(nonDealerButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button2];
        
        
    }
    return self;
}

@end

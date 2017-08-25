//
//  TMGSelectSingleMultiPlayView.m
//  touchMadagascar2
//
//  Created by miura on 2015/03/05.
//  Copyright (c) 2015年 miura. All rights reserved.
//

#import "TMGSelectSingleMultiPlayView.h"
#import "AppUtil.h"
#import "DefineAll.h"
#import "TMGSelectDealerOrNotView.h"
#import "TMGSelectLevelView.h"

@implementation TMGSelectSingleMultiPlayView

- (void)singlePlayButtonTapped:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:TMG_GAME_MODE_SINGLE forKey:TMG_CURRENT_GAME_MODE];
    [defaults synchronize];
    
    int width = 0, height = 0;
    [AppUtil getSubViewDimension:&width height:&height];
    
    TMGSelectLevelView *dealerView = [[TMGSelectLevelView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [self._nav pushView:dealerView animationType:kAnimationTypeSlideInOut];
    [dealerView initializeView];
    
}

- (void)multiPlayButtonTapped:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:TMG_GAME_MODE_MULTI forKey:TMG_CURRENT_GAME_MODE];
    [defaults synchronize];
    
    
    int width = 0, height = 0;
    [AppUtil getSubViewDimension:&width height:&height];
    
    TMGSelectDealerOrNotView *dealerView = [[TMGSelectDealerOrNotView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [self._nav pushView:dealerView animationType:kAnimationTypeSlideInOut];
    [dealerView initializeView];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];
        
        int width = 0, height = 0;
        [AppUtil getSubViewDimension:&width height:&height];
        
        UIImageView *bg_title = [[UIImageView alloc] initWithFrame:CGRectMake(width/2 - 278/2, 65, 278, 22)];
        [bg_title setImage:[UIImage imageNamed:@"01-home_title"]];
        [self addSubview:bg_title];
        
        UIImageView *bg_earth = [[UIImageView alloc] initWithFrame:CGRectMake(width/2 - 153/2, height/2 - 164/2 - 50, 153, 164)];
        [bg_earth setImage:[UIImage imageNamed:@"01-home_bg"]];
        [self addSubview:bg_earth];
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button1 setFrame:CGRectMake(width/2 - 150/2, height-200, 150, 75)];
        [button1.layer setCornerRadius:10];
        [button1 setBackgroundColor:[UIColor whiteColor]];
        [button1.layer setBorderColor:TMG_COLOR_GRAY.CGColor];
        [button1.layer setBorderWidth:2];
        [button1 setTitle:@"Single Play" forState:UIControlStateNormal];
        [button1 setTitleColor:TMG_COLOR_GRAY forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(singlePlayButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button1];
        
        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button2 setFrame:CGRectMake(width/2 - 150/2, height-100, 150, 75)];
        [button2.layer setCornerRadius:10];
        [button2 setBackgroundColor:[UIColor whiteColor]];
        [button2.layer setBorderColor:TMG_COLOR_GRAY.CGColor];
        [button2.layer setBorderWidth:2];
        [button2 setTitle:@"Multi Play" forState:UIControlStateNormal];
        [button2 setTitleColor:TMG_COLOR_GRAY forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(multiPlayButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button2];
        
        
    }
    return self;
}

@end

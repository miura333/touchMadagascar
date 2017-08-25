//
//  TMGSelectLevelView.m
//  touchMadagascar2
//
//  Created by miura on 2015/03/05.
//  Copyright (c) 2015年 miura. All rights reserved.
//

#import "TMGSelectLevelView.h"
#import "AppUtil.h"
#import "DefineAll.h"
#import "TTBCore.h"
#import "TMGQRView.h"
#import "TMG321View.h"

@implementation TMGSelectLevelView

- (void)showQRView:(int)level {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:level forKey:TMG_CURRENT_LEVEL];
    [defaults synchronize];
    
    int country_code_index = [[TTBCore sharedClient] getNumber];
    
    int width = 0, height = 0;
    [AppUtil getSubViewDimension:&width height:&height];
    
    if([[NSUserDefaults standardUserDefaults] integerForKey:TMG_CURRENT_GAME_MODE] == TMG_GAME_MODE_MULTI) {
        TMGQRView *qrView = [[TMGQRView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [self._nav pushView:qrView animationType:kAnimationTypeSlideInOut];
        [qrView initializeView:country_code_index];
        
    }else{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setInteger:country_code_index forKey:TMG_CURRENT_COUNTRY_CODE];
        [defaults synchronize];
        
        TMG321View *gameView = [[TMG321View alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [self._nav pushView:gameView animationType:kAnimationTypeSlideInOut];
        [gameView startCountDown];
        
    }
}

- (void)normalButtonTapped:(id)sender {
    [self showQRView:TMG_GAME_MODE_NORMAL];
}

- (void)hardButtonTapped:(id)sender {
    [self showQRView:TMG_GAME_MODE_HARD];
}

- (void)veryHardButtonTapped:(id)sender {
    [self showQRView:TMG_GAME_MODE_VERY_HARD];
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
        [button1 setTitle:@"Normal" forState:UIControlStateNormal];
        [button1 setTitleColor:TMG_COLOR_GRAY forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(normalButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button1];
        
        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button2 setFrame:CGRectMake(width/2 - 150/2, 200, 150, 75)];
        [button2.layer setCornerRadius:10];
        [button2 setBackgroundColor:[UIColor whiteColor]];
        [button2.layer setBorderColor:TMG_COLOR_GRAY.CGColor];
        [button2.layer setBorderWidth:2];
        [button2 setTitle:@"Hard" forState:UIControlStateNormal];
        [button2 setTitleColor:TMG_COLOR_GRAY forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(hardButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button2];
        
        UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button3 setFrame:CGRectMake(width/2 - 150/2, 300, 150, 75)];
        [button3.layer setCornerRadius:10];
        [button3 setBackgroundColor:[UIColor whiteColor]];
        [button3.layer setBorderColor:TMG_COLOR_GRAY.CGColor];
        [button3.layer setBorderWidth:2];
        [button3 setTitle:@"Very Hard" forState:UIControlStateNormal];
        [button3 setTitleColor:TMG_COLOR_GRAY forState:UIControlStateNormal];
        [button3 addTarget:self action:@selector(veryHardButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button3];
        
        
    }
    return self;
}

@end

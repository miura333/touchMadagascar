//
//  TMGTutoView.m
//  touchMadagascar2
//
//  Created by miura on 2015/03/05.
//  Copyright (c) 2015年 miura. All rights reserved.
//

#import "TMGTutoView.h"
#import "AppUtil.h"
#import "DefineAll.h"
#import "TTBCore.h"
#import "TMG321View.h"

@implementation TMGTutoView

- (void)playButtonTapped:(id)sender {
    int width = 0, height = 0;
    [AppUtil getSubViewDimension:&width height:&height];
    
    TMG321View *gameView = [[TMG321View alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [self._nav pushView:gameView animationType:kAnimationTypeSlideInOut];
    [gameView startCountDown];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];
        
        int width = 0, height = 0;
        [AppUtil getSubViewDimension:&width height:&height];
        
        int qrcode_width = width - 20*2;
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button1 setFrame:CGRectMake(width/2 - 150/2, 80+qrcode_width+10, 150, 75)];
        [button1.layer setCornerRadius:10];
        [button1 setBackgroundColor:[UIColor whiteColor]];
        [button1.layer setBorderColor:TMG_COLOR_GRAY.CGColor];
        [button1.layer setBorderWidth:2];
        [button1 setTitle:@"Play" forState:UIControlStateNormal];
        [button1 setTitleColor:TMG_COLOR_GRAY forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(playButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button1];
        
    }
    return self;
}


@end

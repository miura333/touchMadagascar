//
//  TMG321View.m
//  touchMadagascar2
//
//  Created by miura on 2015/03/05.
//  Copyright (c) 2015年 miura. All rights reserved.
//

#import "TMG321View.h"
#import "AppUtil.h"
#import "DefineAll.h"
#import "TMGGameView.h"

@implementation TMG321View

- (void)closeView {
    int width = 0, height = 0;
    [AppUtil getSubViewDimension:&width height:&height];
    
    int country_code_index = (int)[[NSUserDefaults standardUserDefaults] integerForKey:TMG_CURRENT_COUNTRY_CODE];
    
    TMGGameView *gameView = [[TMGGameView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [self._nav pushView:gameView animationType:kAnimationTypeSlideInOut];
    [gameView startGame:country_code_index];
}

- (void)setupLabel {
    int width = 0, height = 0;
    [AppUtil getSubViewDimension:&width height:&height];
    
    if(_cnt == 3){
        [_label_3 setCenter:CGPointMake((width / 2) + width, height / 2)];
        [_label_2 setCenter:CGPointMake((width / 2) + width, height / 2)];
        [_label_1 setCenter:CGPointMake((width / 2) + width, height / 2)];
        
        [UIView animateWithDuration:0.1 animations:^{
            [_label_3 setCenter:CGPointMake(width / 2, height / 2)];
        }completion:^(BOOL finished){
            _cnt--;
            [self performSelector:@selector(setupLabel) withObject:nil afterDelay:1.0];
        }];
    }else if(_cnt == 2){
        [_label_3 setCenter:CGPointMake(width / 2, height / 2)];
        [_label_2 setCenter:CGPointMake((width / 2) + width, height / 2)];
        [_label_1 setCenter:CGPointMake((width / 2) + width, height / 2)];
        
        [UIView animateWithDuration:0.1 animations:^{
            [_label_3 setCenter:CGPointMake((width / 2) - width, height / 2)];
            [_label_2 setCenter:CGPointMake(width / 2, height / 2)];
        }completion:^(BOOL finished){
            _cnt--;
            [self performSelector:@selector(setupLabel) withObject:nil afterDelay:1.0];
        }];
        
    }else if(_cnt == 1){
        [_label_3 setCenter:CGPointMake((width / 2) - width, height / 2)];
        [_label_2 setCenter:CGPointMake(width / 2, height / 2)];
        [_label_1 setCenter:CGPointMake((width / 2) + width, height / 2)];
        
        [UIView animateWithDuration:0.1 animations:^{
            [_label_2 setCenter:CGPointMake((width / 2) - width, height / 2)];
            [_label_1 setCenter:CGPointMake(width / 2, height / 2)];
        }completion:^(BOOL finished){
            [self performSelector:@selector(closeView) withObject:nil afterDelay:1.0];
        }];
    }
}

- (void)startCountDown {
    _cnt = 3;
    
    [self performSelector:@selector(setupLabel) withObject:nil afterDelay:0];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:[UIColor whiteColor]];
        
        int width = 0, height = 0;
        [AppUtil getSubViewDimension:&width height:&height];
        
        _label_1 = [[UILabel alloc] initWithFrame:CGRectMake(width, height/2-300/2, 300, 300)];
        [_label_1 setFont:[UIFont systemFontOfSize:300]];
        [_label_1 setTextColor:TMG_COLOR_GRAY];
        [_label_1 setTextAlignment:NSTextAlignmentCenter];
        [_label_1 setText:@"1"];
        [_label_1 setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_label_1];
        
        _label_2 = [[UILabel alloc] initWithFrame:CGRectMake(width, height/2-300/2, 300, 300)];
        [_label_2 setFont:[UIFont systemFontOfSize:300]];
        [_label_2 setTextAlignment:NSTextAlignmentCenter];
        [_label_2 setTextColor:TMG_COLOR_GRAY];
        [_label_2 setText:@"2"];
        [_label_2 setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_label_2];
        
        _label_3 = [[UILabel alloc] initWithFrame:CGRectMake(width, height/2-300/2, 300, 300)];
        [_label_3 setFont:[UIFont systemFontOfSize:300]];
        [_label_3 setTextAlignment:NSTextAlignmentCenter];
        [_label_3 setTextColor:TMG_COLOR_GRAY];
        [_label_3 setText:@"3"];
        [_label_3 setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_label_3];
        
    }
    return self;
}

@end

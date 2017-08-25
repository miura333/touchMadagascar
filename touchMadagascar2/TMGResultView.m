//
//  TMGResultView.m
//  touchMadagascar2
//
//  Created by miura on 2015/03/05.
//  Copyright (c) 2015年 miura. All rights reserved.
//

#import "TMGResultView.h"
#import "AppUtil.h"
#import "DefineAll.h"

@implementation TMGResultView

- (void)homeButtonTapped:(id)sender {
    [self._nav popViewToIndex:kAnimationTypeSlideInOut toIndex:0];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];
        
        int width = 0, height = 0;
        [AppUtil getSubViewDimension:&width height:&height];
        
        _label_score = [[UILabel alloc] initWithFrame:CGRectMake(0, 125, width, 80)];
        [_label_score setFont:[UIFont systemFontOfSize:65]];
        [_label_score setTextColor:TMG_COLOR_GRAY];
        [_label_score setBackgroundColor:[UIColor clearColor]];
        [_label_score setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_label_score];
        
        //        _label_best = [[UILabel alloc] initWithFrame:CGRectMake(19, 156, 200, 44)];
        //        [_label_best setFont:[UIFont boldSystemFontOfSize:16]];
        //        [_label_best setTextColor:[UIColor blackColor]];
        //        [_label_best setBackgroundColor:[UIColor clearColor]];
        //        [self addSubview:_label_best];
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button1 setFrame:CGRectMake(width/2 - 150/2, height - 125, 150, 75)];
        [button1.layer setCornerRadius:10];
        [button1 setBackgroundColor:[UIColor whiteColor]];
        [button1.layer setBorderColor:TMG_COLOR_GRAY.CGColor];
        [button1.layer setBorderWidth:2];
        [button1 setTitle:@"Home" forState:UIControlStateNormal];
        [button1 setTitleColor:TMG_COLOR_GRAY forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(homeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button1];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        double score = [defaults doubleForKey:TMG_SCORE];
        
        [_label_score setText:[NSString stringWithFormat:@"%.3f", score]];
        
    }
    return self;
}

@end

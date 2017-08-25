//
//  ARPLNavigationCtrl.m
//  arappli3
//
//  Created by Tester on 12/02/13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ARPLNavigationCtrl.h"
#import "AppUtil.h"

@implementation ARPLNavigationCtrl

- (int)getCurrentPageIndex {
    return [_viewControllers count] - 1;
}

- (void)dissolveAnimationDidEnd_Pop {
    int cnt = [_viewControllers count];
    ARPLNavigationSubViewBase *vc1 = [_viewControllers objectAtIndex:cnt - 2];
    ARPLNavigationSubViewBase *vc2 = [_viewControllers objectAtIndex:cnt - 1];
    [vc2 dissolveAnimationCurrentViewHidden];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3f];    // 時間の指定
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(popAnimationDidEnd)];
    
    [vc1 setAlpha:1.0];
    
    [UIView commitAnimations];
}

- (void)dissolveAnimationDidEnd_Push {
    int cnt = [_viewControllers count];
    ARPLNavigationSubViewBase *vc1 = [_viewControllers objectAtIndex:cnt - 2];
    ARPLNavigationSubViewBase *vc2 = [_viewControllers objectAtIndex:cnt - 1];
    [vc1 dissolveAnimationCurrentViewHidden];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3f];    // 時間の指定
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(pushAnimationDidEnd)];
    
    [vc2 setAlpha:1.0];
    
    [UIView commitAnimations];
}

- (void)popAnimationDidEnd {
    //after animation, delete this
    _animating = NO;
    int cnt = [_viewControllers count];
    UIView *vc1 = [_viewControllers objectAtIndex:cnt - 1];
    
    ARPLNavigationSubViewBase *vc2 = [_viewControllers objectAtIndex:cnt - 2];
    [vc2 setHidden:NO];
    [vc2 popAnimationDidEnd];
    
    [vc1 removeFromSuperview];
    [_viewControllers removeObjectAtIndex:cnt - 1];
}

- (void)pushAnimationDidEnd {
    _animating = NO;
    
    int cnt = [_viewControllers count];
    UIView *vc1 = [_viewControllers objectAtIndex:cnt - 2];
    [vc1 setHidden:YES];
    
    ARPLNavigationSubViewBase *vc2 = [_viewControllers objectAtIndex:cnt - 1];
    [vc2 pushAnimationDidEnd];
}

- (void)popAnimationDidEnd2 {
    //after animation, delete this
    _animating = NO;
    int cnt = [_viewControllers count];
    
    ARPLNavigationSubViewBase *vc2 = [_viewControllers objectAtIndex:_tmp_toIndex];
    [vc2 setHidden:NO];
    [vc2 popAnimationDidEnd];
    [vc2 setAlpha:1.0];
    
    int i = 0;
    for(i = cnt-1; i > _tmp_toIndex; i--){
        UIView *vc1 = [_viewControllers objectAtIndex:i];
        [vc1 removeFromSuperview];
        [_viewControllers removeObjectAtIndex:i];
    }
}

- (void)popViewToIndex:(ARPLNavAnimationType)at toIndex:(int)toIndex {
    int cnt = [_viewControllers count];
    if(cnt <= 1) return;   //error
    
    int width = 0, height = 0;
    [AppUtil getSubViewDimension:&width height:&height];
    
    //animation
    _animating = YES;
    _tmp_toIndex = toIndex;
    
    //after animation, delete this
    UIView *vc1 = [_viewControllers objectAtIndex:cnt - 1];   //現在表示中のvc
    UIView *vc2 = [_viewControllers objectAtIndex:toIndex];   //指定のvc
    
    if(at == kAnimationTypeSlideInOut){
        [vc1 setHidden:NO];
        [vc2 setHidden:NO];
        
        [vc1 setFrame:CGRectMake(0, 0, width, height)];
        [vc2 setFrame:CGRectMake(-width, 0, width, height)];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3f];    // 時間の指定
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(popAnimationDidEnd2)];
        
        [vc1 setFrame:CGRectMake(width, 0, width, height)];
        [vc2 setFrame:CGRectMake(0, 0, width, height)];
        
        [UIView commitAnimations];
        
    }else if(at == kAnimationTypeDissolve){
//        [vc1 setAlpha:1.0];
//        [vc2 setAlpha:0.0];
//        
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        [UIView setAnimationDuration:0.3f];    // 時間の指定
//        [UIView setAnimationDelegate:self];
//        [UIView setAnimationDidStopSelector:@selector(dissolveAnimationDidEnd_Pop2)];
//        
//        [vc1 setAlpha:0.0];    //vc2は0.0のまま
//        
//        [UIView commitAnimations];
        
    }else if(at == kAnimationTypeSlideUpDown){
        [vc1 setHidden:NO];
        [vc2 setHidden:NO];
        
        [vc1 setFrame:CGRectMake(0, 0, width, height)];
        [vc2 setFrame:CGRectMake(0, 0, width, height)];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3f];    // 時間の指定
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(popAnimationDidEnd2)];
        
        [vc1 setFrame:CGRectMake(0, height, width, height)];
        
        [UIView commitAnimations];
        
    }
}

- (void)popCurrentView:(ARPLNavAnimationType)at {
    int cnt = [_viewControllers count];
    if(cnt <= 1) return;   //error
    
    int width = 0, height = 0;
    [AppUtil getSubViewDimension:&width height:&height];
    
    //animation
    _animating = YES;
    
    //after animation, delete this
    UIView *vc1 = [_viewControllers objectAtIndex:cnt - 1];   //現在表示中のvc
    UIView *vc2 = [_viewControllers objectAtIndex:cnt - 2];   //1個前のvc
    
    if(at == kAnimationTypeSlideInOut){
        [vc1 setHidden:NO];
        [vc2 setHidden:NO];
        
        [vc1 setFrame:CGRectMake(0, 0, width, height)];
        [vc2 setFrame:CGRectMake(-width, 0, width, height)];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3f];    // 時間の指定
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(popAnimationDidEnd)];
        
        [vc1 setFrame:CGRectMake(width, 0, width, height)];
        [vc2 setFrame:CGRectMake(0, 0, width, height)];
        
        [UIView commitAnimations];
        
    }else if(at == kAnimationTypeDissolve){
        [vc1 setAlpha:1.0];
        [vc2 setAlpha:0.0];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3f];    // 時間の指定
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(dissolveAnimationDidEnd_Pop)];
        
        [vc1 setAlpha:0.0];    //vc2は0.0のまま
        
        [UIView commitAnimations];
    
    }else if(at == kAnimationTypeSlideUpDown){
        [vc1 setHidden:NO];
        [vc2 setHidden:NO];
        
        [vc1 setFrame:CGRectMake(0, 0, width, height)];
        [vc2 setFrame:CGRectMake(0, 0, width, height)];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3f];    // 時間の指定
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(popAnimationDidEnd)];
        
        [vc1 setFrame:CGRectMake(0, height, width, height)];
        
        [UIView commitAnimations];
    
    }
}

- (void)pushView:(ARPLNavigationSubViewBase *)vc animationType:(ARPLNavAnimationType)at{
    vc._nav = self;
    [_viewControllers addObject:vc];
    [self addSubview:vc];
    
    int cnt = [_viewControllers count];
    if(cnt == 1) return;   //error
    
    int width = 0, height = 0;
    [AppUtil getSubViewDimension:&width height:&height];
    
    //animation
    _animating = YES;
    
    UIView *vc1 = [_viewControllers objectAtIndex:cnt - 2];   //現在表示中のvc
    UIView *vc2 = [_viewControllers objectAtIndex:cnt - 1];   //今追加したvc
    
    if(at == kAnimationTypeSlideInOut){
        [vc1 setHidden:NO];
        [vc2 setHidden:NO];
        
        [vc1 setFrame:CGRectMake(0, 0, width, height)];
        [vc2 setFrame:CGRectMake(width, 0, width, height)];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3f];    // 時間の指定
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(pushAnimationDidEnd)];
        
        [vc1 setFrame:CGRectMake(-width, 0, width, height)];
        [vc2 setFrame:CGRectMake(0, 0, width, height)];
        
        [UIView commitAnimations];
        
    }else if(at == kAnimationTypeDissolve){
        [vc1 setAlpha:1.0];
        [vc2 setAlpha:0.0];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3f];    // 時間の指定
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(dissolveAnimationDidEnd_Push)];
        
        [vc1 setAlpha:0.0];    //vc2は0.0のまま
        
        [UIView commitAnimations];
        
    }else if(at == kAnimationTypeSlideUpDown){
        [vc1 setHidden:NO];
        [vc2 setHidden:NO];
        
        [vc1 setFrame:CGRectMake(0, 0, width, height)];
        [vc2 setFrame:CGRectMake(0, height, width, height)];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3f];    // 時間の指定
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(pushAnimationDidEnd)];
        
        [vc2 setFrame:CGRectMake(0, 0, width, height)];
        
        [UIView commitAnimations];
    }
    
}

- (void)initializeView:(ARPLNavigationSubViewBase *)vc orientation:(UIInterfaceOrientation)io {
    // Custom initialization
    _animating = NO;
    self.io = io;
    _parent = nil;
    
    _viewControllers = [[NSMutableArray alloc] initWithCapacity:1];
    vc._nav = self;
    [_viewControllers addObject:vc];
    
    [self addSubview:vc];
}

- (void)dealloc
{
    int i = 0;
    for(i = 0; i < [_viewControllers count]; i++){
        UIView *vc = [_viewControllers objectAtIndex:i];
        [vc removeFromSuperview];
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)updateUILayout:(UIInterfaceOrientation)io {
    int width = 0, height = 0;
    [AppUtil getSubViewDimension:&width height:&height];
    [self setFrame:CGRectMake(0, 0, width, height)];
    
    int i = 0;
    for(i = 0; i < [_viewControllers count]; i++){
        ARPLNavigationSubViewBase *base = [_viewControllers objectAtIndex:i];
        [base updateUILayout:io];
    }
    self.io = io;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
/*
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    int width = 0, height = 0;
    [ARPLViewUtil getSubViewDimension:&width height:&height orientation:toInterfaceOrientation];
    [self.view setFrame:CGRectMake(0, 0, width, height)];
    
    int i = 0;
    for(i = 0; i < [_viewControllers count]; i++){
        UIViewController *vc = [_viewControllers objectAtIndex:i];
        [vc willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    }
    _io = toInterfaceOrientation;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    int i = 0;
    for(i = 0; i < [_viewControllers count]; i++){
        UIViewController *vc = [_viewControllers objectAtIndex:i];
        [vc didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    }
}
*/
@end

//
//  ARPLNavigationSubViewBase.m
//  arappli3
//
//  Created by Tester on 12/02/13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ARPLNavigationSubViewBase.h"
#import "AppUtil.h"

@implementation ARPLNavigationSubViewBase

- (void)rotateUI:(UIInterfaceOrientation)io {
#if !(TARGET_IPHONE_SIMULATOR)
    //if(io == UIInterfaceOrientationPortrait) return;
    
    //親のナビゲーションクラスごと回転させる。そうしないとツールバーのボタンが押せなくなるため。
    //また縦逆の場合はナビゲーションごと回転させるとツールバーまで回転してしまいそれだと都合が悪い
    //そのためスキャン画面のみ回転させている
    int x = 0, y = 0;
    
    if(io == UIInterfaceOrientationPortrait){
        CGAffineTransform rotate = CGAffineTransformIdentity;
        [self._nav setTransform:rotate];
        
    }else if(io == UIInterfaceOrientationLandscapeLeft){
        CGAffineTransform rotate = CGAffineTransformMakeRotation(90.0f * (M_PI / 180.0f));
        [self._nav setTransform:rotate];
        
        //x = 256;
        
    }else if(io == UIInterfaceOrientationLandscapeRight){
        CGAffineTransform rotate = CGAffineTransformMakeRotation(270.0f * (M_PI / 180.0f));
        [self._nav setTransform:rotate];
        
        //y = -256;
        
    }else if(io == UIInterfaceOrientationPortraitUpsideDown){
        //CGAffineTransform rotate = CGAffineTransformMakeRotation(180.0f * (M_PI / 180.0f));
        //[_widCtrl.view setTransform:rotate];
    }
    
    int width = 0, height = 0;
	[AppUtil getSubViewDimension:&width height:&height];
    
    CGRect frame_tmp = self._nav.frame;
    frame_tmp.origin.x = x;
    frame_tmp.origin.y = y;
    frame_tmp.size.width = width;
    frame_tmp.size.height = height;
    [self._nav setFrame:frame_tmp];
    
    CGRect frame_tmp1 = self.frame;
    frame_tmp1.origin.x = 0;
    frame_tmp1.origin.y = 0;
    frame_tmp1.size.width = width;
    frame_tmp1.size.height = height;
    [self setFrame:frame_tmp1];
    
    //CGRect frame_tmp = self._nav.view.frame;
    //frame_tmp.origin.x = x;
    //frame_tmp.origin.y = y;
    //[self._nav.view setFrame:frame_tmp];
#endif    
}

- (void)dissolveAnimationCurrentViewHidden {
    //here, do nothing
}

- (void)popAnimationDidEnd {
    //here, do nothing
}

- (void)pushAnimationDidEnd {
    //here, do nothing
}

- (void)updateUILayout:(UIInterfaceOrientation)io {
    //here, do nothing
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _toolBar = nil;
        _isEditing = NO;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

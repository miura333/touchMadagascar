//
//  AppUtil.m
//  touchMadagascar
//
//  Created by miura on 2014/11/02.
//  Copyright (c) 2014年 miura. All rights reserved.
//

#import "AppUtil.h"

@implementation AppUtil

+ (void)getSubViewDimension:(int *)width height:(int *)height {
    CGSize result = [[UIScreen mainScreen] bounds].size;
    int width1 = result.width;
    int height1 = result.height;
    
    *width = width1;
    *height = height1;
}

@end

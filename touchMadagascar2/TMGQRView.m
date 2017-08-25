//
//  TMGQRView.m
//  touchMadagascar2
//
//  Created by miura on 2015/03/05.
//  Copyright (c) 2015年 miura. All rights reserved.
//

#import "TMGQRView.h"
#import "AppUtil.h"
#import "DefineAll.h"
#import "TTBCore.h"
#import "TMG321View.h"

@implementation TMGQRView

- (void)playButtonTapped:(id)sender {
    int width = 0, height = 0;
    [AppUtil getSubViewDimension:&width height:&height];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:_country_code forKey:TMG_CURRENT_COUNTRY_CODE];
    [defaults synchronize];
    
    TMG321View *gameView = [[TMG321View alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [self._nav pushView:gameView animationType:kAnimationTypeSlideInOut];
    [gameView startCountDown];
}

- (void)createQRCode:(NSString *)src_str {
    // QRコード作成用のフィルターを作成・パラメータの初期化
    CIFilter *ciFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [ciFilter setDefaults];
    
    // 格納する文字列をNSData形式（UTF-8でエンコード）で用意して設定
    NSData *data = [src_str dataUsingEncoding:NSUTF8StringEncoding];
    [ciFilter setValue:data forKey:@"inputMessage"];
    
    // 誤り訂正レベルを「L（低い）」に設定
    [ciFilter setValue:@"L" forKey:@"inputCorrectionLevel"];
    
    // Core Imageコンテキストを取得したらCGImage→UIImageと変換して描画
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CGImageRef cgimg =
    [ciContext createCGImage:[ciFilter outputImage]
                    fromRect:[[ciFilter outputImage] extent]];
    UIImage *image = [UIImage imageWithCGImage:cgimg scale:1.0f
                                   orientation:UIImageOrientationUp];
    CGImageRelease(cgimg);
    
    int width = 0, height = 0;
    [AppUtil getSubViewDimension:&width height:&height];
    
    int qrcode_width = width - 20*2;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 80, qrcode_width, qrcode_width)];
    imageView.layer.magnificationFilter = kCAFilterNearest;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView setImage:image];
    [self addSubview:imageView];
}

- (void)backButtonTapped:(id)sender {
    [self._nav popCurrentView:kAnimationTypeSlideInOut];
}

- (void)initializeView:(int)num {
    if([self._nav getCurrentPageIndex] > 0) {
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button1 setFrame:CGRectMake(0, 20, 44, 44)];
        [button1 addTarget:self action:@selector(backButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [button1 setImage:[UIImage imageNamed:@"00-icon_back_normal"] forState:UIControlStateNormal];
        [button1 setImage:[UIImage imageNamed:@"00-icon_back_tap"] forState:UIControlStateHighlighted];
        [self addSubview:button1];
    }
    _country_code = num;
    [self createQRCode:[[TTBCore sharedClient] createNumberString:num]];
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

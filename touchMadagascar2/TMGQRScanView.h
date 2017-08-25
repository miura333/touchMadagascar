//
//  TMGQRScanView.h
//  touchMadagascar2
//
//  Created by miura on 2015/03/05.
//  Copyright (c) 2015年 miura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ARPLNavigationSubViewBase.h"

@interface TMGQRScanView : ARPLNavigationSubViewBase <AVCaptureMetadataOutputObjectsDelegate> {
    AVCaptureSession *_session;
    AVCaptureVideoPreviewLayer *_previewLayer;
    BOOL _isDecoded;
    UIView *_baseView;
}

- (void)initializeView;

@end

//
//  TMGQRScanView.m
//  touchMadagascar2
//
//  Created by miura on 2015/03/05.
//  Copyright (c) 2015年 miura. All rights reserved.
//

#import "TMGQRScanView.h"
#import "AppUtil.h"
#import "DefineAll.h"
#import "TTBCore.h"
#import "TMGTutoView.h"

@implementation TMGQRScanView

// Create and configure a capture session and start it running
- (void)setupCaptureSession
{
    int width = 0, height = 0;
    [AppUtil getSubViewDimension:&width height:&height];
    
    NSError *error = nil;
    
    // Create the session
    _session = [[AVCaptureSession alloc] init];
    [_session beginConfiguration];
    // Find a suitable AVCaptureDevice
    AVCaptureDevice *device = [AVCaptureDevice
                               defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Create a device input with the device and add it to the session.
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device
                                                                        error:&error];
    [_session addInput:input];
    
    // Create a VideoDataOutput and add it to the session
    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
    // Configure your output.
    //dispatch_queue_t queue = dispatch_queue_create("myQueue", NULL);
    //[output setSampleBufferDelegate:self queue:queue];
    //    dispatch_release(queue);
    
    // Specify the pixel format
    output.videoSettings =
    [NSDictionary dictionaryWithObject:
     [NSNumber numberWithInt:kCVPixelFormatType_32BGRA]
                                forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    
    [_session addOutput:output];
    [output release];
    
    AVCaptureMetadataOutput *metaOutput = [[AVCaptureMetadataOutput alloc] init];
    [metaOutput setMetadataObjectsDelegate:self
                                     queue:dispatch_queue_create("myQueue.metadata", DISPATCH_QUEUE_SERIAL)];
    [_session addOutput:metaOutput];
    
    metaOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    [metaOutput release];
    
    // Configure the session to produce lower resolution video frames, if your
    // processing algorithm can cope. We'll specify medium quality for the
    // chosen device.
    if([_session canSetSessionPreset:AVCaptureSessionPreset640x480]){	//3G,4
        [_session setSessionPreset:AVCaptureSessionPreset640x480];
    }else{	//3G only
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
    }
    
    [_session commitConfiguration];
    
    // Camera Preview
    _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _previewLayer.frame = CGRectMake(0, 0, width, height-64);
    [_baseView.layer addSublayer:_previewLayer];
    //[_previewLayer release];
    
    //    // Start the session running to start the flow of data
    [_session startRunning];
    
    //[_session release];
}

- (void)stopSession {
    //_isDecoded = NO;
    if(_session != nil){
        [_session stopRunning];
        [_session release];
        _session = nil;
        [_previewLayer removeFromSuperlayer];
        [_previewLayer release];
        _previewLayer = nil;
    }
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
    
    [self setupCaptureSession];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _isDecoded = NO;
        _baseView = nil;
        
        int width = 0, height = 0;
        [AppUtil getSubViewDimension:&width height:&height];
        
        _baseView = [[[UIView alloc] initWithFrame:CGRectMake(0, 64, width, height)] autorelease];
        [self addSubview:_baseView];
    }
    return self;
}

- (void)dealloc {
    [self stopSession];
    [super dealloc];
}

- (void)hoge1:(NSString *)qrar {
    // QRコードの場合、URLとしてmobileSafariを開く
    //[[KPBSECtrl sharedObject] playSound:@"scan_se.caf"];
    
    [self stopSession];
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    int level = 0, index = 0;
    [[TTBCore sharedClient] numberString2num:qrar level:&level index:&index];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:level forKey:TMG_CURRENT_LEVEL];
    [defaults setInteger:index forKey:TMG_CURRENT_COUNTRY_CODE];
    [defaults synchronize];
    
    int width = 0, height = 0;
    [AppUtil getSubViewDimension:&width height:&height];
    
    TMGTutoView *gameView = [[TMGTutoView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [self._nav pushView:gameView animationType:kAnimationTypeSlideInOut];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection
{
    if(_isDecoded) return;
    
    // 認識されたメタデータは複数存在することもあるので、１つずつ調べる
    for (AVMetadataObject *data in metadataObjects) {
        
        // 一次元・二次元コード以外は無視する
        // ※人物顔の識別結果だった場合など
        if (![data isKindOfClass:[AVMetadataMachineReadableCodeObject class]])
            continue;
        
        // コード内の文字列を取得
        NSString *strValue =
        [(AVMetadataMachineReadableCodeObject *)data stringValue];
        
        // 何のタイプとして認識されたかを確認
        if ([data.type isEqualToString:AVMetadataObjectTypeQRCode]) {
            _isDecoded = YES;
            
            [self performSelectorOnMainThread:@selector(hoge1:) withObject:strValue waitUntilDone:NO];
        }
    }
}

@end

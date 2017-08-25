//
//  TMGGameView.m
//  touchMadagascar2
//
//  Created by miura on 2015/03/05.
//  Copyright (c) 2015年 miura. All rights reserved.
//

#import "TMGGameView.h"
#import "AppUtil.h"
#import "DefineAll.h"
#import "TMGResultView.h"
#import "TTBCore.h"

@implementation TMGGameView

- (void)showResultView {
    int width = 0, height = 0;
    [AppUtil getSubViewDimension:&width height:&height];
    
    TMGResultView *resultView = [[TMGResultView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [self._nav pushView:resultView animationType:kAnimationTypeSlideInOut];
}

- (void)giveupButtonTapped:(id)sender {
    [_tm invalidate];
    [_mapView removeAnnotation:_pin];
    
    [self._nav popViewToIndex:kAnimationTypeSlideInOut toIndex:0];
}

-(void)timerCalled:(NSTimer*)timer{
    CFTimeInterval ti = CFAbsoluteTimeGetCurrent();
    _elapsedTime = ti - _orgTime;
    NSString *str1 = [NSString stringWithFormat:@"%.3f", _elapsedTime];
    [_label_time setText:str1];
}

- (void)isAddressValid:(CLLocationCoordinate2D)coordinate block:(void (^)(NSString *results))block {
    
    CLLocation *loc_office = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:loc_office
                   completionHandler:^(NSArray* placemarks, NSError* error) {
                       // 経度、緯度から逆ジオコーディングを行った結果（場所）の数
                       NSLog(@"found : %ld", [placemarks count]);
                       
                       if([placemarks count] == 0){
                           if(block) block(@"Error");
                       }
                       
                       for (CLPlacemark *placemark in placemarks) {
                           // それぞれの結果（場所）の情報
                           NSLog(@"addressDictionary : %@", [placemark.addressDictionary description]);
                           
                           NSLog(@"name : %@", placemark.name);
                           NSLog(@"thoroughfare : %@", placemark.thoroughfare);
                           NSLog(@"subThoroughfare : %@", placemark.subThoroughfare);
                           NSLog(@"locality : %@", placemark.locality);
                           NSLog(@"subLocality : %@", placemark.subLocality);
                           NSLog(@"administrativeArea : %@", placemark.administrativeArea);
                           NSLog(@"subAdministrativeArea : %@", placemark.subAdministrativeArea);
                           NSLog(@"postalCode : %@", placemark.postalCode);
                           NSLog(@"ISOcountryCode : %@", placemark.ISOcountryCode);
                           NSLog(@"country : %@", placemark.country);
                           NSLog(@"inlandWater : %@", placemark.inlandWater);
                           NSLog(@"ocean : %@", placemark.ocean);
                           NSLog(@"areasOfInterest : %@", placemark.areasOfInterest);
                           
                           if(block) block(placemark.ISOcountryCode);
                       }
                   }];
}

// ピンを打つ
-(void)addPin:(CLLocationCoordinate2D) coordinate
{
    if (!_pin) {
        _pin = [TMGLocationPin new];
    } else {
        [_mapView removeAnnotation:_pin];
    }
    
    _pin.coordinate = coordinate;
    
    [_mapView addAnnotation:_pin];
    
    //coordinateから逆ジオコーディングして、お題の場所と合っているか確認
    //合ってたら終了
    [self isAddressValid:coordinate block:^(NSString *results) {
        NSArray *array1 = [[TTBCore sharedClient] getCountryArray];
        
        if([results isEqualToString:array1[_country_index][0]]){
            //結果画面へ
            [_tm invalidate];
            [_mapView removeAnnotation:_pin];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setDouble:_elapsedTime forKey:TMG_SCORE];
            [defaults synchronize];
            
            [self showResultView];
        }
    }];
}

-(void)tapGesture:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded) {
        // タップした位置を緯度経度に変換してピンを打つ
        CGPoint tapPoint = [sender locationInView:_mapView];
        [self addPin:[self.mapView convertPoint:tapPoint toCoordinateFromView:_mapView]];
    }
}

- (void)startGame:(int)country_code {
    NSArray *array1 = [[TTBCore sharedClient] getCountryArray];
    
    [_label_country setText:array1[country_code][1]];
    _country_index = country_code;
    
    _orgTime = CFAbsoluteTimeGetCurrent();
    _tm = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(timerCalled:) userInfo:nil repeats:YES];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        int width = 0, height = 0;
        [AppUtil getSubViewDimension:&width height:&height];
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        _label_time = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, width, 20)];
        [_label_time setFont:[UIFont systemFontOfSize:16]];
        [_label_time setTextColor:TMG_COLOR_GRAY];
        [_label_time setBackgroundColor:[UIColor clearColor]];
        [_label_time setTextAlignment:NSTextAlignmentRight];
        [self addSubview:_label_time];
        
        _label_country = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, width, 30)];
        [_label_country setBackgroundColor:[UIColor clearColor]];
        [_label_country setTextColor:TMG_COLOR_GRAY];
        [_label_country setFont:[UIFont systemFontOfSize:16]];
        [_label_country setNumberOfLines:0];
        [_label_country setMinimumScaleFactor:1.0];
        [_label_country setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_label_country];
        
        UIButton *btn_giveup = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn_giveup.layer setCornerRadius:6];
        [btn_giveup.layer setBorderColor:TMG_COLOR_GRAY.CGColor];
        [btn_giveup.layer setBorderWidth:1.0];
        [btn_giveup setFrame:CGRectMake(10, 20+(50/2-25/2), 65, 25)];
        //[btn_giveup setBackgroundColor:[UIColor lightGrayColor]];
        [btn_giveup.titleLabel setFont:[UIFont systemFontOfSize:10]];
        [btn_giveup setTitle:@"ギブアップ" forState:UIControlStateNormal];
        [btn_giveup setTitle:@"ギブアップ" forState:UIControlStateHighlighted];
        [btn_giveup setTitleColor:TMG_COLOR_GRAY forState:UIControlStateNormal];
        [btn_giveup setTitleColor:TMG_COLOR_GRAY forState:UIControlStateHighlighted];
        [btn_giveup addTarget:self action:@selector(giveupButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn_giveup];
        
        _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 70, width, height - 70)];
        [self addSubview:_mapView];
        
        _mapView.showsUserLocation = YES;
        _mapView.delegate = self;
        
        // ピンを打つためのタッチジェスチャーを登録
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(tapGesture:)];
        [tapGestureRecognizer setNumberOfTapsRequired:1];
        [_mapView addGestureRecognizer:tapGestureRecognizer];
        
    }
    return self;
}

@end

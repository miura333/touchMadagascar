//
//  TMGLocationPin.h
//  touchMadagascar
//
//  Created by miura on 2014/11/02.
//  Copyright (c) 2014年 miura. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface TMGLocationPin : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end

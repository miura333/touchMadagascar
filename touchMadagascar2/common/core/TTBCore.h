//
//  TTBCore.h
//  touchTheBingo
//
//  Created by miura on 2015/02/26.
//  Copyright (c) 2015年 miura. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTBCore : NSObject

+ (instancetype)sharedClient;

- (NSArray *)getCountryArray;
- (int)getNumber;
- (NSString *)createNumberString:(int)num1;
- (void)numberString2num:(NSString *)str level:(int *)level index:(int *)index;

@end

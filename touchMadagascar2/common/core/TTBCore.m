//
//  TTBCore.m
//  touchTheBingo
//
//  Created by miura on 2015/02/26.
//  Copyright (c) 2015年 miura. All rights reserved.
//

#import "TTBCore.h"
#import "DefineAll.h"

@implementation TTBCore

+ (instancetype)sharedClient
{
    static TTBCore *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[TTBCore alloc] init];
    });
    
    return _sharedClient;
}

- (NSArray *)getCountryArray {
    int level = (int)[[NSUserDefaults standardUserDefaults] integerForKey:TMG_CURRENT_LEVEL];
    NSArray *array1 = nil;
    if(level == TMG_GAME_MODE_NORMAL) {
        array1 = TMG_COUNTRY_DATA_NORMAL;
        
    }else if(level == TMG_GAME_MODE_HARD) {
        array1 = TMG_COUNTRY_DATA_HARD;
        
    }else if(level == TMG_GAME_MODE_VERY_HARD) {
        array1 = TMG_COUNTRY_DATA_VERY_HARD;
        
    }
    return array1;
}

- (int)getNumber {
    NSArray *array1 = [self getCountryArray];
    int count = (int)[array1 count];
    return arc4random() % count;
}

//QRコード生成用の文字列を作成する
- (NSString *)createNumberString:(int)num1 {
    NSString *uuidString = [[NSUUID UUID] UUIDString];
    int level = (int)[[NSUserDefaults standardUserDefaults] integerForKey:TMG_CURRENT_LEVEL];
    
    NSString *str = [NSString stringWithFormat:@"%02d%02d", level, num1];
    str = [str stringByAppendingString:@"##"];
    str = [str stringByAppendingString:uuidString];
    
    return str;
}
//生成文字列を国コードにデコードする
- (void)numberString2num:(NSString *)str level:(int *)level index:(int *)index{
    NSRange range1 = [str rangeOfString:@"##"];
    if(range1.length == 0) return;
    
    NSString *code_str = [str substringToIndex:range1.location];
    NSString *str1 = [code_str substringToIndex:2];
    int level1 = [str1 intValue];
    *level = level1;
    
    NSString *str2 = [code_str substringWithRange:NSMakeRange(2, 2)];
    int index1 = [str2 intValue];
    *index = index1;
}


@end

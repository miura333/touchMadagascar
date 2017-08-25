//
//  ViewController.m
//  touchMadagascar2
//
//  Created by miura on 2015/03/05.
//  Copyright (c) 2015年 miura. All rights reserved.
//

#import "ViewController.h"
#import "AppUtil.h"
#import "TMGSelectSingleMultiPlayView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    int width = 0, height = 0;
    [AppUtil getSubViewDimension:&width height:&height];
    
    TMGSelectSingleMultiPlayView *smView = [[TMGSelectSingleMultiPlayView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    _nav = [[ARPLNavigationCtrl alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [_nav initializeView:smView orientation:UIInterfaceOrientationPortrait];
    [self.view addSubview:_nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

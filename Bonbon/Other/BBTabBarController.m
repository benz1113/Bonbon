//
//  BBTabBarController.m
//  Bonbon
//
//  Created by 周峰 on 2017/10/12.
//  Copyright © 2017年 word. All rights reserved.
//

#import "BBTabBarController.h"
#import <DKNightVersion/DKNightVersion.h>

@interface BBTabBarController ()

@end

@implementation BBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBar dk_setBarTintColorPicker:DKColorPickerWithKey(BAR)];
    [self.tabBar dk_setTintColorPicker:DKColorPickerWithKey(TINT)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

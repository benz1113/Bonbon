//
//  BBSettingTableViewController.m
//  Bonbon
//
//  Created by 周峰 on 2017/7/27.
//  Copyright © 2017年 word. All rights reserved.
//

#import "BBSettingTableViewController.h"
#import "BBUser.h"
#import <DKNightVersion/DKNightVersion.h>

@interface BBSettingTableViewController ()

@end

@implementation BBSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self styleForNight];
    [self initSwitch];
}

-(void)initSwitch{
    if([self.dk_manager.themeVersion isEqualToString: DKThemeVersionNight]){
        [self.nightModeSwitch setOn:YES];
    }
    else{
        [self.nightModeSwitch setOn:NO];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logOutAction:(id)sender
{
    [BBUser removeUser];
    //获取storyboard
    UIStoryboard *login = [UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]];
    //获取注销后要跳转的页面
    id view = [login instantiateViewControllerWithIdentifier:@"login"];
    //模态展示出登陆页面
    [self presentViewController:view animated:YES completion:^{     }];
}

- (IBAction)switchIntoNightMode:(id)sender
{
    if(_nightModeSwitch.isOn){
        // 关闭切换为夜间模式
        [self.dk_manager nightFalling];
        
        NSNotification* notice = [NSNotification notificationWithName:@"夜间模式" object:nil userInfo:@{@"state":@"开启"}];
        [[NSNotificationCenter defaultCenter] postNotification:notice];
    }
    else{
        // 打开切换为白天模式
        [self.dk_manager dawnComing];
        
        NSNotification* notice = [NSNotification notificationWithName:@"夜间模式" object:nil userInfo:@{@"state":@"关闭"}];
        [[NSNotificationCenter defaultCenter] postNotification:notice];
    }
}

-(void)styleForNight
{
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    
    for(UITableViewCell* cell in self.cells){
        cell.dk_backgroundColorPicker = DKColorPickerWithKey(CELL);
        cell.backgroundView.dk_backgroundColorPicker = DKColorPickerWithKey(CELL);        
    }
    
    for(UILabel* label in self.cellLabels){
        label.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    }
}

@end

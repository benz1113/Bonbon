//
//  BBSettingTableViewController.h
//  Bonbon
//
//  Created by 周峰 on 2017/7/27.
//  Copyright © 2017年 word. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBSettingTableViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UISwitch *nightModeSwitch;

@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *cells;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *cellLabels;

@end

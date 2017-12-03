//
//  BBWordListViewController.h
//  Bonbon
//
//  Created by 周峰 on 2017/7/20.
//  Copyright © 2017年 word. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBWordListViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISegmentedControl *wordlistSeg;

@property (strong, nonatomic) IBOutlet UITableView *wordTableView;

@end

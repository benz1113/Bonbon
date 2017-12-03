//
//  BBPunchViewController.h
//  Bonbon
//
//  Created by 周峰 on 2017/7/20.
//  Copyright © 2017年 word. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FSCalendar;

@interface BBPunchViewController : UIViewController

@property (strong, nonatomic) IBOutlet FSCalendar *calendar;

@property (strong, nonatomic) IBOutlet UIButton *punchBtn;

@property (strong, nonatomic) IBOutlet UILabel *punchDays;

@property (strong, nonatomic) NSMutableArray* signArray;
@end

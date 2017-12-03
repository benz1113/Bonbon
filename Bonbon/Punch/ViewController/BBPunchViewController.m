//
//  BBPunchViewController.m
//  Bonbon
//
//  Created by 周峰 on 2017/7/20.
//  Copyright © 2017年 word. All rights reserved.
//

#import "BBPunchViewController.h"
#import <FSCalendar/FSCalendar.h>
#import "BBUser.h"
#import "BBDatabase.h"
#import "BBTool.h"

@interface BBPunchViewController ()

@end

@implementation BBPunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSignData];
    [self initCalendar];
}

-(void)loadSignData
{
    if(!_signArray){
        _signArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:[BBUser sharedUser].punchData]];
    }
    
    for(id date in self.signArray){
        [_calendar selectDate:date];
    }
    
    self.punchDays.text = [NSString stringWithFormat:@"已经连续打卡%ld天",[self getPunchDays:self.signArray]];
}
-(NSInteger)getPunchDays:(NSMutableArray*)signArray
{
    if(signArray.count == 0){
        return 0;
    }
    NSInteger dayCount = 1;
    NSDate *preDate, *nextDate;
    double interval;
    
    for(unsigned long i = signArray.count - 1; i > 0; i--){
        preDate = [signArray objectAtIndex:i];
        nextDate = [signArray objectAtIndex:i-1];
        interval = [preDate timeIntervalSinceReferenceDate] - [nextDate timeIntervalSinceReferenceDate];
        
        if(1 == interval/60/60/24){
            dayCount++;
            continue;
        }
        else{
            break;
        }
    }
    return dayCount;
}

-(void)initCalendar
{
    _calendar.calendarHeaderView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    
    _calendar.calendarWeekdayView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    
    _calendar.appearance.selectionColor = [UIColor colorWithRed:25.0/255.0 green:138.0/255.0 blue:136.0/255.0 alpha:1];
    
    _calendar.appearance.weekdayTextColor = [UIColor colorWithRed:25.0/255.0 green:138.0/255.0 blue:136.0/255.0 alpha:1];
    
    _calendar.appearance.headerTitleColor=[UIColor colorWithRed:25.0/255.0 green:138.0/255.0 blue:136.0/255.0 alpha:1];
    
    _calendar.today = nil;
    
    _calendar.firstWeekday = 2;     //设置周一为第一天
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文
    
    _calendar.locale = locale;  // 设置周次是中文显示
    
    _calendar.userInteractionEnabled = false; //屏蔽点击
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)punchToday:(id)sender
{
    if([self.signArray containsObject:[BBTool extractDate:[NSDate date]]]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"已经打好啦～" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [alert show];
        return;
    }
    else{
        [self.signArray addObject:[BBTool extractDate:[NSDate date]]];
        self.punchDays.text = [NSString stringWithFormat:@"已经连续打卡%ld天",[self getPunchDays:self.signArray]];
        [_calendar selectDate:[NSDate date]];
        NSData *sendData=[NSKeyedArchiver archivedDataWithRootObject:self.signArray];
        [BBUser sharedUser].punchData = sendData;
        [BBUser saveUser];
        [[BBDatabase sharedDataBase] updateUser:[BBUser sharedUser]];
        NSLog(@"punch ok!");
    }
}

@end

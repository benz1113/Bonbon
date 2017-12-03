//
//  BBMyTableViewController.m
//  Bonbon
//
//  Created by 周峰 on 2017/7/20.
//  Copyright © 2017年 word. All rights reserved.
//

#import "BBMyTableViewController.h"
#import "BBUser.h"
#import <DKNightVersion/DKNightVersion.h>

@interface BBMyTableViewController ()

@end

@implementation BBMyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self styleForNight];
    [self initData];
}

-(void)initData{
    NSString* n = [BBUser sharedUser].nickName;
    if(n != nil){
        self.userName.text = [BBUser sharedUser].nickName;
    }
    else{
        self.userName.text = [BBUser sharedUser].userName;
    }
    CGSize labelsize = [self.userName.text boundingRectWithSize:CGSizeMake(200, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:self.userName.font forKey:NSFontAttributeName] context:nil].size;
    
    self.userName.frame = CGRectMake(98,15, labelsize.width, labelsize.height);
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [super tableView:tableView numberOfRowsInSection:section];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




@end

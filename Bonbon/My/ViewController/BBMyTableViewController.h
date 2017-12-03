//
//  BBMyTableViewController.h
//  Bonbon
//
//  Created by 周峰 on 2017/7/20.
//  Copyright © 2017年 word. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBMyTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *userAvada;

@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *cells;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *cellLabels;


@end

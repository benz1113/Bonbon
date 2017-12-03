//
//  BBWordListViewController.m
//  Bonbon
//
//  Created by 周峰 on 2017/7/20.
//  Copyright © 2017年 word. All rights reserved.
//

#import "BBWordListViewController.h"
#import "BBDatabase.h"
#import "BBWord.h"
#import "BBUser.h"

@interface BBWordListViewController (){
    NSInteger tag;
    NSMutableArray* arrayOfWord;
    NSMutableArray* arrayOfKeyWord;
}


@end

@implementation BBWordListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self initData];
}

-(void)initData
{
    arrayOfWord = [[BBDatabase sharedDataBase] getWordsFromUser:[BBUser sharedUser]];
    [self.wordlistSeg addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    arrayOfKeyWord =[[NSMutableArray alloc] init];
    for(BBWord* word in arrayOfWord){
        if(word.isKeynote){
            [arrayOfKeyWord addObject:word];
        }
    }
    
}
-(void)change:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0){
        tag = 0;
    }else if (sender.selectedSegmentIndex == 1){
        tag = 1;
    }
    else{
        tag = -1;
    }
    [self.wordTableView reloadData];
}


#pragma mark - 数据源方法

// 返回行数
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tag == 0?arrayOfWord.count:arrayOfKeyWord.count;

}

// 设置cell
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc ] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    if(tag == 0){
        
        BBWord *word = arrayOfWord[indexPath.row];
        cell.textLabel.text = word.key;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",word.meaning];
        
    }else if(tag == 1){
        
        BBWord *word = arrayOfKeyWord[indexPath.row];
        cell.textLabel.text = word.key;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",word.meaning];
    }
    return cell;
}

@end

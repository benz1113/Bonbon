//
//  BBLearningViewController.h
//  Bonbon
//
//  Created by 周峰 on 2017/7/27.
//  Copyright © 2017年 word. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "BBWordList.h"
#import "BBLearningContentView.h"

@interface BBLearningViewController : UIViewController

@property (weak, nonatomic) IBOutlet BBLearningContentView *lv;

@property (nonatomic, strong) BBWordList *wordList;
@property (nonatomic, strong) NSArray *wordsArray;
@property (nonatomic, unsafe_unretained) int cursor1;
@property (nonatomic, strong) NSMutableArray *examContentsQueue;
@property (nonatomic, strong) NSMutableArray *examViewReuseQueue;


@property (strong, nonatomic) IBOutlet UIButton *badgeBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *wrongBtn;
@property (nonatomic, strong) NSMutableSet *wrongWordsSet;




- (IBAction)rightButtonOnPress:(id)sender;
- (IBAction)wrongButtonOnPress:(id)sender;
- (void)calculateFamiliarityForContentQueue:(NSMutableArray *)contentQueue;

@end

//
//  BBLearningViewController.m
//  Bonbon
//
//  Created by 周峰 on 2017/7/27.
//  Copyright © 2017年 word. All rights reserved.
//

#import "BBLearningViewController.h"
#import "BBDatabase.h"
#import "BBUser.h"
#import "BBTool.h"

static CGFloat NotificationViewHeight = 48;

@interface BBLearningViewController ()
{
    NSMutableArray *arrayOfWord;
    BBWord *word;
}

@property (nonatomic, unsafe_unretained) BOOL animationLock;
@property (nonatomic, unsafe_unretained) BOOL downloadLock;
@property (nonatomic, unsafe_unretained) BBLearningContent *currentLearningContent;
@property (nonatomic, unsafe_unretained) BOOL shouldUpdateWordFamiliarity;

//@property (nonatomic, strong) SimpleProgressBar *progressBar;

@property (NS_NONATOMIC_IOSONLY, readonly, strong) BBLearningContentView *pickALearningView;

@property (nonatomic, strong) NSURLSession *requestSession;

- (void)createLearningContentsArray;
- (void)shuffleMutableArray:(NSMutableArray *)array;
- (void)prepareNextLearningView;

- (void)examViewExchangeDidFinish:(BBLearningContentView *)currLearningView;

@end

@implementation BBLearningViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"单元学习";
    
    _cursor1 = 0;
    _shouldUpdateWordFamiliarity = NO;
    self.lv.acceptationView.backgroundColor = [UIColor clearColor];
    [self updateBarBtn];
    
    [self getWordFromData];
    [self initLearningContent:_cursor1];
}

-(void)initLearningContent:(NSInteger)cursor
{
    word = [arrayOfWord objectAtIndex:cursor];
    
    self.lv.keyLabel.text = word.key;
    self.lv.acceptationView.text = word.attributedWordDetail;
    [[BBDatabase sharedDataBase] addWord:word toUser:[BBUser sharedUser]];
}

-(void)getWordFromData
{
    arrayOfWord = [[NSMutableArray alloc]init];
    arrayOfWord = [[BBDatabase sharedDataBase] getWordsFromUnit:2 withNumber:5];
}

- (void)commonInit {
    _examContentsQueue = [[NSMutableArray alloc]init];
    _examViewReuseQueue = [[NSMutableArray alloc]initWithCapacity:2];
    _wrongWordsSet = [[NSMutableSet alloc]init];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    _requestSession = [NSURLSession sessionWithConfiguration:config];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ibactions

- (IBAction)badgeBtnOnPress:(id)sender
{
    [[BBDatabase sharedDataBase] updateWord:word ofUser:[BBUser sharedUser]];
    word.isKeynote = !word.isKeynote;
    [self updateBarBtn];
}

-(void)updateBarBtn
{
    if(word.isKeynote){
        UIImage* image = [UIImage imageNamed:@"collect"];
        image = [BBTool reSizeImage:image toSize:CGSizeMake(30, 30)];
        [self.badgeBtn setImage:image forState:UIControlStateNormal];
    }
    else{
        UIImage* image = [UIImage imageNamed:@"collect_pre"];
        image = [BBTool reSizeImage:image toSize:CGSizeMake(30, 30)];
        [self.badgeBtn setImage:image forState:UIControlStateNormal];
    }
}

- (IBAction)rightButtonOnPress:(id)sender
{
    
    if (_animationLock) {
        return;
    }
    self.currentLearningContent.rightTimes++;
    [self prepareNextLearningView];
}

- (IBAction)wrongButtonOnPress:(id)sender
{
    if (_animationLock) {
        return;
    }
    self.rightBtn.enabled = YES;
    self.currentLearningContent.wrongTimes++;
    [self.wrongWordsSet addObject:self.currentLearningContent.word];
    [self prepareNextLearningView];
}

#pragma mark - private methods
- (BBLearningContentView *)pickALearningView
{
    static int i = 0;
    BBLearningContentView *view = (self.examViewReuseQueue)[i%2];
    i++;
    return view;
}

- (void)shuffleMutableArray:(NSMutableArray *)array
{
    NSInteger i = [array count];
    while(--i > 0) {
        NSUInteger j = arc4random() % (i+1);
        [array exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
}

-(void) prepareNextLearningView
{
    _cursor1 = ++_cursor1;
    _cursor1 = _cursor1 % arrayOfWord.count;
    
    [self initLearningContent:_cursor1];
    
    if(self.lv.showAcceptationBtn.hidden){
    self.lv.showAcceptationBtn.hidden = NO;
    self.lv.acceptationView.hidden = YES;
    self.lv.wordDish.hidden = NO;
    self.lv.keyLabel.frame = CGRectMake(self.lv.keyLabel.frame.origin.x,
                                        self.lv.keyLabel.frame.origin.y + 70,
                                        self.lv.keyLabel.frame.size.width,
                                        self.lv.keyLabel.frame.size.height);
    
    self.lv.wordDish.frame = CGRectMake(self.lv.wordDish.frame.origin.x + self.lv.wordDish.frame.size.width,
                                     self.lv.wordDish.frame.origin.y, self.lv.wordDish.frame.size.width, self.lv.wordDish.frame.size.height);
    }
    [self updateBarBtn];
}

#pragma mark - 隐藏tabBar

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
    
}

@end

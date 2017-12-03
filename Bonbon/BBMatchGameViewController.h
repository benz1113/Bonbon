//
//  BBMatchGameViewController.h
//  Bonbon
//
//  Created by 周峰 on 2017/11/14.
//  Copyright © 2017年 word. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBMatchGame.h"

@interface BBMatchGameViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UIView *gameGrip;

@property (strong, nonatomic) NSString *gameType;
@property (nonatomic) NSUInteger numberOfMatchWords;
@property (nonatomic) CGSize maxCardSize;
@property (nonatomic) BOOL removeMatchingCards;

@property (nonatomic,strong) BBMatchGame* game;
@end

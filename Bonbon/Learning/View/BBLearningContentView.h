//
//  BBLearningContentView.h
//  Bonbon
//
//  Created by 周峰 on 2017/9/7.
//  Copyright © 2017年 word. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBLearningContent.h"

@interface BBLearningContentView : UIView
@property (nonatomic, weak) IBOutlet UILabel *keyLabel;
@property (nonatomic, weak) IBOutlet UITextView *acceptationView;
@property (nonatomic, weak) IBOutlet UIButton *showAcceptationBtn;
@property (nonatomic,weak) BBLearningContent* content;
@property (strong, nonatomic) IBOutlet UIImageView *wordDish;


+ (id)newInstance;
- (IBAction)showAcceptationButtonOnPressed:(id)sender;
@end

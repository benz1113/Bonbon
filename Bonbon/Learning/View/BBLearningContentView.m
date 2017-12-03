//
//  BBLearningContentView.m
//  Bonbon
//
//  Created by 周峰 on 2017/9/7.
//  Copyright © 2017年 word. All rights reserved.
//

#import "BBLearningContentView.h"

@implementation BBLearningContentView


- (IBAction)showAcceptationButtonOnPressed:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    btn.hidden = YES;
    self.acceptationView.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.keyLabel.frame = CGRectMake(self.keyLabel.frame.origin.x,
                                         self.keyLabel.frame.origin.y - 70, self.keyLabel.frame.size.width, self.keyLabel.frame.size.height);
        self.wordDish.frame = CGRectMake(self.wordDish.frame.origin.x - self.wordDish.frame.size.width,
                                         self.wordDish.frame.origin.y, self.wordDish.frame.size.width, self.wordDish.frame.size.height);
    } completion:^(BOOL finished) {
        self.wordDish.hidden = YES;
    }];
}

@end

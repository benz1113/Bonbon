//
//  BBLearningContent.m
//  Bonbon
//
//  Created by 周峰 on 2017/9/7.
//  Copyright © 2017年 word. All rights reserved.
//

#import "BBLearningContent.h"

@implementation BBLearningContent

- (instancetype)initWithWord:(BBWord *)word
{
    self = [super init];
    if (self) {
        _word = word;
        _rightTimes = _wrongTimes = 0;
    }
    return self;
}

- (int)weight
{
    //权值=等待时间/熟悉度
    //熟悉度=正确次数/错误次数
    //权值=错误次数*时间/正确次数
    
    NSTimeInterval time = [_lastReviewDate timeIntervalSinceNow]*(-1);
    
    float familiarity = 0;
    if (self.rightTimes != 0 || self.wrongTimes != 0) {
        familiarity = ((float)(self.rightTimes))/(self.rightTimes+self.wrongTimes);
    }
    if (familiarity == 0) {
        //防止除0
        familiarity = 0.01;
    }
    int weight = (int)(sqrt(time)/(familiarity*familiarity));
    if (weight <0) {
        //溢出
        weight = -weight;
    }
    return weight;
}

- (NSString *)description
{

    return [NSString stringWithFormat:@"word:%@,weight:%d",[self.word description],[self weight]];
}

@end

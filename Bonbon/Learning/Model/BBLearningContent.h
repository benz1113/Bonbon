//
//  BBLearningContent.h
//  Bonbon
//
//  Created by 周峰 on 2017/9/7.
//  Copyright © 2017年 word. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBWord.h"

typedef NS_OPTIONS(NSUInteger, UnitOption) {
    UnitOptionNone = 0,
    UnitOption2 = 1 << 0,
    UnitOption3 = 1 << 1,
    UnitOption4 = 1 << 2,
    UnitOption5 = 1 << 3,
    UnitOption6 = 1 << 4,
    UnitOption7 = 1 << 5,
    UnitOption8 = 1 << 6,
    UnitOption9 = 1 << 7,
    UnitOption10 = 1 << 8,
    UnitOption11 = 1 << 9,
    UnitOption12 = 1 << 10,
    UnitOption13 = 1 << 11,
    UnitOption14 = 1 << 12
} ;

@interface BBLearningContent : NSObject

@property (nonatomic, strong) BBWord *word;
@property (nonatomic, unsafe_unretained) int rightTimes;
@property (nonatomic, unsafe_unretained) int wrongTimes;
@property (nonatomic, strong) NSDate *lastReviewDate;

- (instancetype)initWithWord:(BBWord *)word;
@property (NS_NONATOMIC_IOSONLY, readonly) int weight;   //计算权值
@end

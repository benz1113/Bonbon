//
//  BBGameResult.h
//  Bonbon
//
//  Created by 周峰 on 2017/11/22.
//  Copyright © 2017年 word. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBGameResult : NSObject

+ (NSArray *)allGameResults; // of GameResults

@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (readonly, nonatomic) NSTimeInterval duration;
@property (nonatomic) int score;
@property (strong, nonatomic) NSString *gameType;

- (NSComparisonResult)compareScore:(BBGameResult *)result;
- (NSComparisonResult)compareDuration:(BBGameResult *)result;
- (NSComparisonResult)compareDate:(BBGameResult *)result;

@end

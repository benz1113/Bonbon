//
//  BBMatchGame.h
//  Bonbon
//
//  Created by 周峰 on 2017/11/22.
//  Copyright © 2017年 word. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BBMatchCard;

@interface BBMatchGame : NSObject

- (instancetype)initWithWordCount:(NSUInteger)count;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (BBMatchCard *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSUInteger maxMatchingCards;
@property (nonatomic, readonly) NSArray *lastChosenCards;
@property (nonatomic, readonly) NSInteger lastScore;

@property (nonatomic, readonly) NSUInteger numberOfDealtCards;

@property (nonatomic, readonly) BOOL deckIsEmpty;

@property (nonatomic) int matchBonus;
@property (nonatomic) int mismatchPenalty;
@property (nonatomic) int flipCost;


@end

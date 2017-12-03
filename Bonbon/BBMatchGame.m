//
//  BBMatchGame.m
//  Bonbon
//
//  Created by 周峰 on 2017/11/22.
//  Copyright © 2017年 word. All rights reserved.
//

#import "BBMatchGame.h"
#import "BBMatchCard.h"
#import "BBWord.h"
#import "BBDatabase.h"
#import "BBTool.h"

@interface BBMatchGame ()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@property (nonatomic, strong) NSMutableArray *words; // of Word
@property (nonatomic, strong) NSArray *lastChosenCards;
@property (nonatomic, readwrite) NSInteger lastScore;

@end


@implementation BBMatchGame

- (instancetype)initWithWordCount:(NSUInteger)count
{
    self = [super init];
    
    if (self) {
        self.words = [[BBDatabase sharedDataBase] getWordsFromUnit:2 withNumber:count];
        for (int i = 0; i < count; i++) {
            BBWord *word = [self.words objectAtIndex:i];
            BBMatchCard *card = [[BBMatchCard alloc] initWithText:word.key AtX:0 Y:0];
            card.matchTag = i;
            [self.cards addObject:card];
            card = [[BBMatchCard alloc] initWithText:word.meaning AtX:0 Y:0];
            card.matchTag = i;
            [self.cards addObject:card];
            _matchBonus = MATCH_BONUS;
            _mismatchPenalty = MISMATCH_PENALTY;
            _flipCost = COST_TO_CHOOSE;
        }
        [BBTool shuffle:self.cards];
    }
    
    return self;
}

static const int MISMATCH_PENALTY = 4;
static const int MATCH_BONUS = 2;
static const int COST_TO_CHOOSE = 1;

- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (NSMutableArray *)words {
    if (!_words) {
        _words = [[NSMutableArray alloc] init];
    }
    return _words;
}

- (NSUInteger)maxMatchingCards
{
    BBMatchCard *card = [self.cards firstObject];
    if (_maxMatchingCards < card.numberOfMatchingCards) {
        _maxMatchingCards = card.numberOfMatchingCards;
    }
    return _maxMatchingCards;
}

- (NSUInteger)numberOfDealtCards {
    return [self.cards count];
}

- (BBMatchCard *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    BBMatchCard *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            NSMutableArray *otherCards = [NSMutableArray array];
            for (BBMatchCard *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [otherCards addObject:otherCard];
                }
            }
            self.lastScore = 0;
            self.lastChosenCards = [otherCards arrayByAddingObject:card];
            card.chosen = YES;
            if ([otherCards count] + 1 == self.maxMatchingCards) {
                int matchScore = [card match:otherCards];
                if (matchScore) {
                    self.lastScore = matchScore * self.matchBonus;
                    card.matched = YES;
                    for (BBMatchCard *otherCard in otherCards) {
                        otherCard.matched = YES;
                    }
                } else {
                    self.lastScore = - self.mismatchPenalty;
                    for (BBMatchCard *otherCard in otherCards) {
                        otherCard.chosen = NO;
                    }
                    card.chosen = NO;
                }
            }
            self.score += self.lastScore - self.flipCost;
            
        }
    }
}

- (NSArray *)nextCombinationAfter:(NSArray *)combination withNumberOfCards:(NSUInteger)numberOfCards
{
    NSUInteger n = [self.cards count];
    NSUInteger k = numberOfCards;
    NSUInteger i = k - 1;
    NSMutableArray *next = [combination mutableCopy];
    next[i] = @([next[i] intValue] + 1);
    while ((i > 0) && ([next[i] intValue] > n - k + i)) {
        i--;
        next[i] = @([next[i] intValue] + 1);
    }
    if ([next[0] intValue] > n - k) return nil;
    for (i = i + 1; i < k; ++i) {
        next[i] = @([next[i - 1] intValue] + 1);
    }
    return next;
}

- (NSArray *)cardsFromCombination:(NSArray *)combination startinWithIndex:(NSUInteger)start
{
    NSMutableArray *cards = [[NSMutableArray alloc] init];
    for (NSUInteger i = start; i < [combination count]; i++) {
        [cards addObject:self.cards[[combination[i] intValue]]];
    }
    return cards;
}

- (NSArray *)cardsFromCombination:(NSArray *)combination
{
    return [self cardsFromCombination:combination startinWithIndex:0];
}

- (NSArray *)otherCardsFromCombination:(NSArray *)combination
{
    return [self cardsFromCombination:combination startinWithIndex:1];
}

- (BOOL)validCombination:(NSArray *)combination
{
    for (NSNumber *index in combination) {
        BBMatchCard *card = self.cards[[index intValue]];
        if (card.matched) return NO;
    }
    return YES;
}

- (NSArray *)findCombination
{
    BBMatchCard *card = [self.cards firstObject];
    NSMutableArray *combination = [NSMutableArray array];
    for (NSUInteger i = 0; i < card.numberOfMatchingCards; i++) {
        [combination addObject:@(i)];
    }
    
    NSArray *foundCombination;
    NSArray *nextCombination = combination;
    do {
        if (![self validCombination:nextCombination]) continue;
        if ([self.cards[[nextCombination[0] intValue]] match:[self otherCardsFromCombination:nextCombination]]) {
            foundCombination = [self cardsFromCombination:nextCombination];
            break;
        }
    } while ((nextCombination = [self nextCombinationAfter:nextCombination withNumberOfCards:card.numberOfMatchingCards]));
    
    return foundCombination;
}

@end

//
//  BBMatchCard.h
//  Bonbon
//
//  Created by 周峰 on 2017/11/14.
//  Copyright © 2017年 word. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BBMatchCard;

@interface BBMatchCard : UILabel

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;
@property (nonatomic, assign) NSUInteger matchTag;

@property (nonatomic) NSUInteger numberOfMatchingCards;

- (int)match:(NSArray *)otherCards;

@property (nonatomic, strong) NSString *notificationDrawline;

- (id)initWithText:(NSString*)text AtX:(NSInteger)x Y:(NSInteger)y;

@end

//
//  WordList.h
//  Bonbon
//
//  Created by 周峰 on 2017/7/27.
//  Copyright © 2017年 word. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BBBaseModel.h"

@class BBWord;

@interface BBWordList : BBBaseModel

@property (nonatomic, retain) NSDate * addTime;
@property (nonatomic, retain) NSNumber * effectiveCount;
@property (nonatomic, retain) NSDate * lastReviewTime;
@property (nonatomic, retain) NSString * synchronizeTag;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *words;

@end

@interface BBWordList (CoreDataGeneratedAccessors)

- (void)addWordsObject:(BBWord *)value;
- (void)removeWordsObject:(BBWord *)value;
- (void)addWords:(NSSet *)values;
- (void)removeWords:(NSSet *)values;

@end

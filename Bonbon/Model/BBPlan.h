//
//  Plan.h
//  Bonbon
//
//  Created by 周峰 on 2017/7/27.
//  Copyright © 2017年 word. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BBBaseModel.h"

@class BBWordList;

@interface BBPlan : BBBaseModel

@property (nonatomic, retain) NSDate * createDate;
//@property (nonatomic, retain) NSNumber * learningFinished;
@property (nonatomic, retain) BBWordList *learningPlan;
@property (nonatomic, retain) NSOrderedSet *reviewPlan;
@end

@interface BBPlan (CoreDataGeneratedAccessors)

- (void)insertObject:(BBWordList *)value inReviewPlanAtIndex:(NSUInteger)idx;
- (void)removeObjectFromReviewPlanAtIndex:(NSUInteger)idx;
- (void)insertReviewPlan:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeReviewPlanAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInReviewPlanAtIndex:(NSUInteger)idx withObject:(BBWordList *)value;
- (void)replaceReviewPlanAtIndexes:(NSIndexSet *)indexes withReviewPlan:(NSArray *)values;
- (void)addReviewPlanObject:(BBWordList *)value;
- (void)removeReviewPlanObject:(BBWordList *)value;
- (void)addReviewPlan:(NSOrderedSet *)values;
- (void)removeReviewPlan:(NSOrderedSet *)values;

@end


//
//  Note.h
//  Bonbon
//
//  Created by 周峰 on 2017/7/27.
//  Copyright © 2017年 word. All rights reserved.
//

#import "BBBaseModel.h"

@class BBWord;

@interface BBNote : BBBaseModel

@property (nonatomic, retain) NSString * textNote;
@property (nonatomic, retain) NSSet *attatchments;
@property (nonatomic, retain) BBWord *word;
@end

@interface BBNote (CoreDataGeneratedAccessors)

- (void)addAttatchmentsObject:(NSManagedObject *)value;
- (void)removeAttatchmentsObject:(NSManagedObject *)value;
- (void)addAttatchments:(NSSet *)values;
- (void)removeAttatchments:(NSSet *)values;

@end

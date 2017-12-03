//
//  BBDatabase.h
//  Bonbon
//
//  Created by 周峰 on 2017/10/8.
//  Copyright © 2017年 word. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BBWordList;
@class BBWord;
@class BBPlan;
@class BBUser;

@interface BBDatabase : NSObject


+(instancetype)sharedDataBase;

#pragma mark - User
/**
 *  添加user
 *
 */
-(void)addUser:(BBUser*)user;
/**
 *  删除user
 *
 */
-(void)deleteUser:(BBUser*)user;
/**
 *  删除user
 *
 */
-(BBUser*)getUserWithName:(NSString*)userName;
/**
 *  更新user
 *
 */
- (void)updateUser:(BBUser*)user;
/**
 *  检查user
 *
 */
- (bool)checkUser:(BBUser*)user;
/**
 *  获取所有数据
 *
 */
- (NSMutableArray *)getAllUser;

#pragma mark - Word
/**
 *  获取word
 *
 */
-(NSMutableArray*)getWordsFromUnit:(NSInteger)unit withNumber:(NSInteger)num;
/**
 *  给user添加word
 *
 */
-(void)addWord:(BBWord*)word toUser:(BBUser*)user;
/**
 *  给user删除word
 *
 */
-(void)deleteWord:(BBWord*)word fromUser:(BBUser*)user;
/**
 *  获取user所有word
 *
 */
-(NSMutableArray*)getWordsFromUser:(BBUser*)user;
/**
 *  删除user所有word
 *
 */
-(void)deleteAllWordsFromUser:(BBUser*)user;
/**
 *  标记word
 *
 */
-(void)updateWord:(BBWord*)word ofUser:(BBUser*)user;

@end

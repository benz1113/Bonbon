//
//  Word.h
//  Bonbon
//
//  Created by 周峰 on 2017/7/27.
//  Copyright © 2017年 word. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BBBaseModel.h"

@class BBNote, BBPronunciationData, BBWord, BBWordList;

@interface BBWord : NSObject
/**
 词解
 */
@property (nonatomic, retain) NSString * acceptation;

/**
 熟悉度
 */
@property (nonatomic, retain) NSNumber * familiarity;

/**
 是否手动输入（如果手动输入，不需要从网上请求词解）
 */
@property (nonatomic, retain) NSNumber * manuallyInput;

/**
 是否已从网上取得词解
 */
@property (nonatomic, retain) NSNumber * hasGotDataFromAPI;
/**
 是否标记
 */
@property (nonatomic) bool isKeynote;

/**
 单词本身
 */
@property (nonatomic) NSString * key;

/**
 名词词性
 */
@property (nonatomic) NSString * noun;

/**
 复数
 */
@property (nonatomic) NSString * plurality;

/**
 词性
 */
@property (nonatomic) NSString * POS;

/**
 单三
 */
@property (nonatomic, retain) NSString * DOEs;

/**
 过去式
 */
@property (nonatomic, retain) NSString * pastTense;

/**
 完成式
 */
@property (nonatomic, retain) NSString * perfectTense;

/**
 最后复习时间
 */
@property (nonatomic, retain) NSDate * lastViewDate;

/**
 音标
 */
@property (nonatomic, retain) NSString * ps;

/**
 汉意
 */
@property (nonatomic, retain) NSString * meaning;

/**
 例句
 */
@property (nonatomic, retain) NSString * sentence;

/**
 翻译
 */
@property (nonatomic, retain) NSString * translation;

/**
 发音
 */
@property (nonatomic, retain) BBPronunciationData *pronunciation;

/**
 易混淆词汇
 */
@property (nonatomic, retain) NSSet *similarWords;

/**
 存在于wordList
 */
@property (nonatomic, retain) NSSet *wordLists;

/**
 笔记
 */
@property (nonatomic, retain) BBNote *note;


// transient property

/**
 用于学习界面中text view的内容
 */
@property (nonatomic, readonly) NSMutableString *attributedWordDetail;

@end

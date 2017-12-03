//
//  PronunciationData.h
//  Bonbon
//
//  Created by 周峰 on 2017/7/27.
//  Copyright © 2017年 word. All rights reserved.
//

#import "BBBaseModel.h"

@class BBWord;

@interface BBPronunciationData : BBBaseModel

@property (nonatomic, retain) NSData * pronData;
@property (nonatomic, retain) BBWord *word;

@end

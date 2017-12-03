//
//  Word.m
//  Bonbon
//
//  Created by 周峰 on 2017/7/27.
//  Copyright © 2017年 word. All rights reserved.
//

#import "BBWord.h"
#import <UIKit/UIKit.h>
@implementation BBWord

- (NSMutableString *)attributedWordDetail
{
    NSMutableString *jointStr = [[NSMutableString alloc]init];
    if (self.noun.length != 0) {
        [jointStr appendFormat:@"名词词性[%@]\n",self.noun];
    }
    if (self.plurality.length != 0) {
        [jointStr appendFormat:@"复数[%@]\n",self.plurality];
    }
    if (self.POS.length != 0) {
        [jointStr appendFormat:@"词性[%@]\n",self.POS];
    }
    if (self.DOEs.length != 0) {
        [jointStr appendFormat:@"单三[%@]\n",self.DOEs];
    }
    if (self.pastTense.length != 0) {
        [jointStr appendFormat:@"过去式[%@]\n",self.pastTense];
    }
    if (self.perfectTense.length != 0) {
        [jointStr appendFormat:@"完成式[%@]\n",self.perfectTense];
    }
    if (self.meaning.length != 0) {
        [jointStr appendFormat:@"汉意[%@]\n",self.meaning];
    }
    if (self.sentence.length != 0) {
        [jointStr appendFormat:@"\n例句\n%@\n",self.sentence];
    }
    if (self.translation.length != 0) {
        [jointStr appendFormat:@"\n翻译\n%@\n",self.translation];
    }
    
    return jointStr;
}
@end

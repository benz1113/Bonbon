//
//  BBTool.h
//  Bonbon
//
//  Created by 周峰 on 2017/10/21.
//  Copyright © 2017年 word. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BBTool : NSObject

+ (NSDate *)extractDate:(NSDate *)date;

+ (void)shuffle:(NSMutableArray*)array;

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;

@end

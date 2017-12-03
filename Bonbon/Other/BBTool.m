//
//  BBTool.m
//  Bonbon
//
//  Created by 周峰 on 2017/10/21.
//  Copyright © 2017年 word. All rights reserved.
//

#import "BBTool.h"

@implementation BBTool

+ (NSDate *)extractDate:(NSDate *)date
{
    //get seconds since 1970
    NSTimeInterval interval = [date timeIntervalSince1970];
    int daySeconds = 24 * 60 * 60;
    //calculate integer type of days
    NSInteger allDays = interval / daySeconds;
    
    return [NSDate dateWithTimeIntervalSince1970:allDays * daySeconds];
}

+(void)shuffle:(NSMutableArray *)array
{
    int count = (int)array.count;
    for (int i = 0; i < count; ++i) {
        int n = (arc4random() % (count - i)) + i;
        [array exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [reSizeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end

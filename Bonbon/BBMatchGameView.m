//
//  BBMatchGameView.m
//  Bonbon
//
//  Created by 周峰 on 2017/11/14.
//  Copyright © 2017年 word. All rights reserved.
//

#import "BBMatchGameView.h"

@implementation BBMatchGameView

#pragma mark - Draw Line
- (UIImage *)drawLineWithColor:(UIColor *)color width:(CGFloat)width startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    UIImage *image = nil;
    
    UIGraphicsBeginImageContext(self.frame.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, width);
    CGContextSetStrokeColorWithColor(context, [color CGColor]);
    
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    
    CGContextStrokePath(context);
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - Touch Events
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    //NSLog(@"begin point: (%f,%f)", point.x, point.y);

}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    //NSLog(@"moved point: (%f,%f)", point.x, point.y);
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    //NSLog(@"ended point: (%f,%f)", point.x, point.y);
}

@end

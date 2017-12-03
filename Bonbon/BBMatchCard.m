//
//  BBMatchCard.m
//  Bonbon
//
//  Created by 周峰 on 2017/11/14.
//  Copyright © 2017年 word. All rights reserved.
//

#import "BBMatchCard.h"
#import "BBTool.h"

@implementation BBMatchCard

-(id)initWithText:(NSString *)text AtX:(NSInteger)x Y:(NSInteger)y
{
    self = [super init];
    
    if(self != nil){
        self.userInteractionEnabled = YES;
        self.numberOfLines = 0;
        self.text = text;
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont fontWithName:@"Arial" size:15];
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 10;
        self.highlightedTextColor = [UIColor redColor];
        
        CGSize size = CGSizeMake(200,200); //设置一个行高上限
        NSDictionary *attribute = @{NSFontAttributeName: self.font};
        CGSize labelSize = [self.text boundingRectWithSize:size options:NSStringDrawingUsesDeviceMetrics attributes:attribute context:nil].size;
        self.frame = CGRectMake(x, y, 80, 80/*labelSize.width + 15, 30*/);
    }
    
    return self;
}

- (NSUInteger)numberOfMatchingCards
{
    if (!_numberOfMatchingCards) _numberOfMatchingCards = 2;
    return _numberOfMatchingCards;
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    NSUInteger numOtherCards = [otherCards count];
    
    if (numOtherCards) {
        for (BBMatchCard *otherCard in otherCards) {
            if (self.matchTag == otherCard.matchTag) {
                    score += 1;
            }
        }
    }
    if (numOtherCards > 1) {
        score += [[otherCards firstObject] match:[otherCards subarrayWithRange:NSMakeRange(1, numOtherCards - 1)]];
    }
    return score;
}

- (void)cardEvent:(UITapGestureRecognizer *)gesture
{
    // 获取到坐标值
    CGPoint locationPoint = [gesture locationInView:self];
    
    // 状态1
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        
    }
    
    // 状态2
    if(gesture.state == UIGestureRecognizerStateChanged)
    {
        
    }
    
    // 状态3
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        if (locationPoint.x <= self.bounds.size.width && locationPoint.x >= 0 &&
            locationPoint.y <= self.bounds.size.height && locationPoint.y >= 0)
        {
            
            
        }
    }
}


@end

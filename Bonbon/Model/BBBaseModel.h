//
//  BBBaseModel.h
//  Bonbon
//
//  Created by 周峰 on 2017/7/27.
//  Copyright © 2017年 word. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface BBBaseModel : NSManagedObject

 - (NSDictionary *)toDict;

- (NSString *)toJSON;

@end

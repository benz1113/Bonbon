//
//  BBBaseModel.m
//  Bonbon
//
//  Created by 周峰 on 2017/7/27.
//  Copyright © 2017年 word. All rights reserved.
//

#import "BBBaseModel.h"

@implementation BBBaseModel

- (NSDictionary *)toDict {
    NSArray *allAttributesKeys = [self.entity.attributesByName allKeys];
    NSDictionary *relationships = self.entity.relationshipsByName;
    NSMutableDictionary *dictRepresentation = [[NSMutableDictionary alloc]initWithCapacity:allAttributesKeys.count];
    for (NSString *aKey in allAttributesKeys) {
        id value = [self valueForKey:aKey];
        if ([value isKindOfClass: [NSString class]] || [value isKindOfClass: [NSNumber class]]) {
            [dictRepresentation setObject:value forKey:aKey];
        }else if([value isKindOfClass:[NSDate class]]){
            NSTimeInterval timePassed = [((NSDate *)value) timeIntervalSince1970];
            [dictRepresentation setObject:@(timePassed) forKey:aKey];
        }else if ([value isKindOfClass: [BBBaseModel class]]) {
            [dictRepresentation setObject:[((BBBaseModel *)value) toDict]forKey:aKey];
        }
    }
    NSManagedObjectID *objId = self.objectID;
    [dictRepresentation setObject:[[objId URIRepresentation]absoluteString] forKey:@"ObjectID"];
    return dictRepresentation;
}

- (NSString *)toJSON {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[self toDict] options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
}
@end

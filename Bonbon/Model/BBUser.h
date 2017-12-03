//
//  BBUser.h
//  Bonbon
//
//  Created by 周峰 on 2017/10/2.
//  Copyright © 2017年 word. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBWordList.h"
#import <UIKit/UIKit.h>

@interface BBUser : NSObject

+ (instancetype)sharedUser;

@property (nonatomic, retain) NSString * userName;

@property (nonatomic, retain) NSString * nickName;

@property (nonatomic, retain) NSData* userAvatar;

@property (nonatomic, retain) NSString * password;

@property (nonatomic, strong) NSData* punchData;

@property (nonatomic, retain) BBWordList * wordList;

+ (BOOL)isAutoLogin;

+ (void)saveUser;

+ (void)removeUser;

-(void)setUser:(BBUser*)user;

@end

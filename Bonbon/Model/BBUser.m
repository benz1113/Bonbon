//
//  BBUser.m
//  Bonbon
//
//  Created by 周峰 on 2017/10/2.
//  Copyright © 2017年 word. All rights reserved.
//

#import "BBUser.h"

@implementation BBUser

+(instancetype)sharedUser
{
    static BBUser * user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[BBUser alloc] init];
    });
    return user;
}

-(instancetype)init
{
    self = [super init];
    if(self){
        
        _userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
        _password = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
        _nickName = [[NSUserDefaults standardUserDefaults] objectForKey:@"nickName"];
        _punchData = [[NSUserDefaults standardUserDefaults] objectForKey:@"punchData"];
    }
    return self;
}

+(BOOL)isAutoLogin
{
    if([BBUser sharedUser].userName.length == 0){
        return NO;
    }
    return YES;
}

-(void)setUser:(BBUser *)user
{
    [[BBUser sharedUser] setUserName:user.userName];
    [[BBUser sharedUser] setPassword:user.password];
    [[BBUser sharedUser] setNickName:user.nickName];
    [[BBUser sharedUser] setPunchData:user.punchData];
    [[BBUser sharedUser] setUserAvatar:user.userAvatar];
}

+(void)saveUser
{
    [[NSUserDefaults standardUserDefaults] setObject:[BBUser sharedUser].userName forKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] setObject:[BBUser sharedUser].password forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] setObject:[BBUser sharedUser].nickName forKey:@"nickName"];
    [[NSUserDefaults standardUserDefaults] setObject:[BBUser sharedUser].punchData forKey:@"punchData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+(void)removeUser
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"nickName"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"punchData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
@end

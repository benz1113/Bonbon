//
//  BBDatabase.m
//  Bonbon
//
//  Created by 周峰 on 2017/10/8.
//  Copyright © 2017年 word. All rights reserved.
//

#import "BBDatabase.h"
#import <FMDB/FMDB.h>
#import "BBUser.h"
#import "BBWord.h"
#import "BBWordList.h"
static BBDatabase *_DBCtl = nil;

@interface BBDatabase()<NSCopying,NSMutableCopying>{
    FMDatabase *_db;
    
}

@end

@implementation BBDatabase

+(instancetype)sharedDataBase
{
    if(_DBCtl == nil){
        
        _DBCtl = [[BBDatabase alloc] init];
        
        [_DBCtl initDataBase];
    }
    
    return _DBCtl;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    if (_DBCtl == nil) {
        
        _DBCtl = [super allocWithZone:zone];
        
    }
    
    return _DBCtl;
    
}

-(id)copy{
    
    return self;
    
}

-(id)mutableCopy{
    
    return self;
    
}

-(id)copyWithZone:(NSZone *)zone{
    
    return self;
    
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    
    return self;
    
}

-(void)initDataBase{
    // 获得Documents目录路径
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 文件路径
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"BBvocabolary.db3"];
    
    //拷贝至沙盒
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:filePath]) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *filePathAgo = [bundle pathForResource:@"BBvocabolary" ofType:@"db3"];
        [fileManager copyItemAtPath:filePathAgo toPath:filePath error:&error];
        //NSLog(@"filenameAgo>>>>%@",filePathAgo);
        //NSLog(@"filename%@",filePath);
    }
    
    // 实例化FMDataBase对象
    _db = [FMDatabase databaseWithPath:filePath];
    
    
}

#pragma mark - User
-(BBUser*)getUserWithName:(NSString *)userName
{
    BBUser *user = [[BBUser alloc] init];
    
    [_db open];
    
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM user WHERE username = '%@'", userName]];

    while ([res next]) {
        [user setUserName:[res stringForColumn:@"username"]];
        [user setPassword:[res stringForColumn:@"password"]];
        [user setNickName:[res stringForColumn:@"nickname"]];
        [user setUserAvatar:[res dataForColumn:@"useravatar"]];
        [user setPunchData:[res dataForColumn:@"punchdata"]];
    }
    [_db close];
    return user;

}

-(void)addUser:(BBUser *)user
{
    [_db open];
    
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT username FROM user WHERE username = '%@'", user.userName]];
    //检查重复用户
    while ([res next]) {
        if ([user.userName isEqualToString:[res stringForColumn:@"username"]]) {
            [_db close];
            return;
        }
    }
    BOOL success = [_db executeUpdate:@"INSERT INTO user (username, password) VALUES(?, ?)",user.userName,user.password];
    if (!success) {
        NSLog(@"error = %@", [_db lastErrorMessage]);
    }
    [_db close];
    
}

-(bool)checkUser:(BBUser *)user
{
    [_db open];
    
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM user WHERE username = '%@' AND password = '%@'",user.userName, user.password]];
    while([res next]){
            [_db close];
            return YES;
    }

    [_db close];
    return NO;
}

- (void)updateUser:(BBUser*)user
{
    [_db open];
    
    BOOL success = [_db executeUpdate:@"UPDATE user SET punchdata = ? WHERE username = ?",user.punchData, user.userName];
    if (!success) {
        NSLog(@"error = %@", [_db lastErrorMessage]);
    }
    [_db close];
    
}


#pragma mark - Word
-(NSMutableArray*)getWordsFromUnit:(NSInteger)unit withNumber:(NSInteger)num
{
    NSMutableArray* words = [[NSMutableArray alloc] init];
    [_db open];
    
    NSString* sql_stmt = [NSString stringWithFormat:@"SELECT * FROM word WHERE unit = %ld ORDER BY RANDOM() limit %ld", unit, num];
    
    FMResultSet *res = [_db executeQuery:sql_stmt];
    
    
    while([res next]){
        BBWord* word = [[BBWord alloc] init];
        
        [word setKey:[res stringForColumn:@"key"]];
        [word setNoun:[res stringForColumn:@"noun"]];
        [word setPlurality:[res stringForColumn:@"plurality"]];
        [word setPOS:[res stringForColumn:@"pos"]];
        [word setDOEs:[res stringForColumn:@"does"]];
        [word setPastTense:[res stringForColumn:@"pasttense"]];
        [word setPerfectTense:[res stringForColumn:@"perfecttense"]];
        [word setMeaning:[res stringForColumn:@"meaning"]];
        [word setSentence:[res stringForColumn:@"sentence"]];
        [word setTranslation:[res stringForColumn:@"translation"]];
        
        [words addObject:word];
    }
    [_db close];
    return words;
}

-(NSMutableArray*)getWordsFromUser:(BBUser *)user
{
    NSMutableArray* words = [[NSMutableArray alloc] init];
    [_db open];
    NSString* sql_stmt = [NSString stringWithFormat:@"SELECT * FROM wordlist wl, word w WHERE wl.key = w.key AND username = '%@'", user.userName];
    
    FMResultSet *res = [_db executeQuery:sql_stmt];
    
    while([res next]){
        BBWord* word = [[BBWord alloc] init];
        
        [word setKey:[res stringForColumn:@"key"]];
        [word setNoun:[res stringForColumn:@"noun"]];
        [word setPlurality:[res stringForColumn:@"plurality"]];
        [word setPOS:[res stringForColumn:@"pos"]];
        [word setDOEs:[res stringForColumn:@"does"]];
        [word setPastTense:[res stringForColumn:@"pasttense"]];
        [word setPerfectTense:[res stringForColumn:@"perfecttense"]];
        [word setMeaning:[res stringForColumn:@"meaning"]];
        [word setSentence:[res stringForColumn:@"sentence"]];
        [word setTranslation:[res stringForColumn:@"translation"]];
        [word setIsKeynote:[res boolForColumn:@"iskeynote"]];
        [words addObject:word];
    }
    [_db close];
    
    return words;
}


-(void)addWord:(BBWord *)word toUser:(BBUser *)user
{
    [_db open];
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT key FROM wordlist WHERE username = '%@'", user.userName]];
    //检查重复单词
    while ([res next]) {
        if ([word.key isEqualToString:[res stringForColumn:@"key"]]) {
            [_db close];
            return;
        }
    }
    BOOL success = [_db executeUpdate:@"INSERT INTO wordlist (username, key) VALUES(?, ?)",user.userName,word.key];
    if (!success) {
        NSLog(@"error = %@", [_db lastErrorMessage]);
    }
    [_db close];
}

-(void)updateWord:(BBWord *)word ofUser:(BBUser *)user
{
    [_db open];
    
    NSString* sql_stmt = [NSString stringWithFormat:@"UPDATE wordlist SET iskeynote = %d WHERE username = '%@' AND key = '%@'",!word.isKeynote, user.userName, word.key];
    
    BOOL success = [_db executeUpdate:sql_stmt];
    if (!success) {
        NSLog(@"error = %@", [_db lastErrorMessage]);
    }
    [_db close];
}
@end

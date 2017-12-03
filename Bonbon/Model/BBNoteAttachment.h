//
//  NoteAttachment.h
//  Bonbon
//
//  Created by 周峰 on 2017/7/27.
//  Copyright © 2017年 word. All rights reserved.
//

#import "BBBaseModel.h"

@class BBNote;

@interface BBNoteAttachment : BBBaseModel

@property (nonatomic, retain) NSData * data;
@property (nonatomic, retain) NSString * mimeType;
@property (nonatomic, retain) BBNote *note;

@end

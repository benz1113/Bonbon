//
//  BBLoginViewController.h
//  Bonbon
//
//  Created by 周峰 on 2017/10/2.
//  Copyright © 2017年 word. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ModeType) {
    LoginMode, //登录
    RegidterMode //注册
} ;

@interface BBLoginViewController : UIViewController

@property (nonatomic, unsafe_unretained) ModeType modeType;

@property (retain, nonatomic) IBOutlet UIButton *modeBtn;

@property (retain, nonatomic) IBOutlet UIButton *shiftBtn;

@property (strong, nonatomic) IBOutlet UITextField *usernameField;

@property (strong, nonatomic) IBOutlet UITextField *passwordField;

@end

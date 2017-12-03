//
//  BBLoginViewController.m
//  Bonbon
//
//  Created by 周峰 on 2017/10/2.
//  Copyright © 2017年 word. All rights reserved.
//

#import "BBLoginViewController.h"
#import "BBUser.h"
#import "BBDatabase.h"

@interface BBLoginViewController ()

@end


@implementation BBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.modeType = LoginMode;
}


- (IBAction)modeAction:(id)sender
{
    BBUser* user = [[BBUser alloc] init];
    [user setUserName:self.usernameField.text];
    [user setPassword:self.passwordField.text];
    
    if(self.modeType == LoginMode){
        if([[BBDatabase sharedDataBase] checkUser:user]){
            [[BBUser sharedUser] setUser:[[BBDatabase sharedDataBase] getUserWithName:user.userName]];
            [BBUser saveUser];
            
            //获取storyboard
            UIStoryboard *login = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            //获取注销后要跳转的页面
            id view = [login instantiateViewControllerWithIdentifier:@"main"];
            //模态展示出登陆页面
            [self presentViewController:view animated:YES completion:^{     }];
        }
        else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"用户名或密码错误！请重新登录" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
    else if(self.modeType == RegidterMode){
        
        if(![[BBDatabase sharedDataBase] checkUser:user]){
            [[BBDatabase sharedDataBase] addUser:user];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"注册成功！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"您已经注册过啦！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        
        
    }
}
- (IBAction)shiftMode:(id)sender
{
    if(self.modeType == LoginMode){
        self.modeType = RegidterMode;
        [self.modeBtn setImage:[UIImage imageNamed:@"Register_btn.png"] forState:UIControlStateNormal];
        [self.shiftBtn setTitle:@"已有账号？立即登录" forState:UIControlStateNormal];
    }
    else if(self.modeType == RegidterMode){
        self.modeType = LoginMode;
        [self.modeBtn setImage:[UIImage imageNamed:@"Login_btn.png"] forState:UIControlStateNormal];
        [self.shiftBtn setTitle:@"还没有账号？立即注册" forState:UIControlStateNormal];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    return [textField resignFirstResponder];
    
}


@end

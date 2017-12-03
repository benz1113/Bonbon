//
//  BBNavigationController.m
//  Bonbon
//
//  Created by 周峰 on 2017/10/7.
//  Copyright © 2017年 word. All rights reserved.
//

#import "BBNavigationController.h"
#import <DKNightVersion/DKNightVersion.h>

@interface BBNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic, weak) id PopDelegate;

@end


     
@implementation BBNavigationController

+(void)initialize
{
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];    
     [navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"]forBarMetrics:UIBarMetricsDefault];
     [navigationBar setTintColor:[UIColor whiteColor]];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    if (viewController.navigationItem.leftBarButtonItem ==nil && self.viewControllers.count >1) {
        viewController.navigationItem.leftBarButtonItem = [self creatBackButton];
    }
}

-(UIBarButtonItem *)creatSpaceItem
{
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = - 15;
    return spaceItem;
}

-(UIBarButtonItem *)creatBackButton
{
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBackBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    return leftBackBarButtonItem;
}

-(void)popSelf
{
    [self popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.PopDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = self.PopDelegate;
    }else{
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

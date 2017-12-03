//
//  BBMyViewController.m
//  Bonbon
//
//  Created by 周峰 on 2017/7/20.
//  Copyright © 2017年 word. All rights reserved.
//

#import "BBMyViewController.h"
#import "BBMyTableViewController.h"

@interface BBMyViewController ()
@property (weak,nonatomic)BBMyTableViewController* embedVC;
@end

@implementation BBMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)presentWordlist:(id)sender {
    [self performSegueWithIdentifier:@"My2Wordlist" sender:sender];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"EmbedSegue"]) {
            self.embedVC = (BBMyTableViewController *)segue.destinationViewController;
        }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  ZM_NavigationViewController.m
//  WOT
//
//  Created by GVS on 16/9/2.
//  Copyright © 2016年 GVS. All rights reserved.
//

#import "ZM_NavigationViewController.h"

@interface ZM_NavigationViewController ()

@end

@implementation ZM_NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UINavigationController * navigationController = [[UINavigationController alloc] init];
    self.navigationBar.barTintColor = [UIColor colorWithRed:37/255.0f green:34/255.0f blue:35/255.0f alpha:CGFLOAT_DEFINED];
    NSLog(@"111");
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

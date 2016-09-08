//
//  ZM_DetailViewController.m
//  WOT
//
//  Created by GVS on 16/9/8.
//  Copyright © 2016年 GVS. All rights reserved.
//

#import "ZM_DetailViewController.h"
#import "Header.h"
@interface ZM_DetailViewController ()<UIWebViewDelegate,ZM_MenuViewProtocol>
@property (nonatomic, strong)UIWebView * webView;
@property (nonatomic, assign)NSNumber * zone;
@property (nonatomic, copy)NSString * pn;
@end

@implementation ZM_DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:45/255.0f green:42/255.0f blue:43/255.0f alpha:1.0f];
    self.zone = self.dataDict[@"zone"];
    self.pn = self.dataDict[@"pn"];
    self.navigationItem.title = self.pn;
    ZM_MenuView * menuView = [[ZM_MenuView alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 40)];
    NSArray * array = @[@"战绩",@"能力",@"数据"];
    menuView.backgroundColor = [UIColor whiteColor];
    menuView.delegate = self;
    [menuView setMenueWithArray:array];
    [self.view addSubview:menuView];
    [self createWebViewWithTag:0];
//    menuView.frame = 
//    self.navigationItem.title = self.title;
}
-(void)createWebViewWithTag:(NSInteger)tag
{
   self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.webView.delegate = self;
    
    switch (tag) {
        case 0:
        {
            NSLog(@"%@",[NSString stringWithFormat:QUEREY,self.pn,self.zone]);
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:QUEREY,self.pn,self.zone]]]];
           break;
        }
        case 1:
        {
            NSLog(@"%@",[NSString stringWithFormat:ABILITY,self.pn,self.zone]);
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:ABILITY,self.pn,self.zone]]]];
            break;
        }
        case 2:
        {
            NSLog(@"%@",[NSString stringWithFormat:BATTLEDATA,self.pn,self.zone]);
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:BATTLEDATA,self.pn,self.zone]]]];
            break;
        }
        default:
            break;
    }
    [self.view addSubview:self.webView];
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"%s",__func__);
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"%s",__func__);
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%s",__func__);
    return YES;
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

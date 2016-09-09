//
//  TestViewController.m
//  WOT
//
//  Created by GVS on 16/9/9.
//  Copyright © 2016年 GVS. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()<UIWebViewDelegate>
@property (nonatomic, strong)UIWebView * webView;
@end
#define URLSTRING @"http://wotapp.duowan.com/index.php?r=m/home&pn=无名指上的纨绔&zone=0"
@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.view.backgroundColor = [UIColor grayColor];
    self.webView.delegate = self;
    NSString * string = URLSTRING;
    string = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]]];
    [self.view addSubview:self.webView];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"%s",__func__);
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"%s",__func__);
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%s",__func__);
    NSLog(@"%@",[error localizedDescription]);
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

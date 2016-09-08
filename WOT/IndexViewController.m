//
//  ViewController.m
//  WOT
//
//  Created by GVS on 16/8/30.
//  Copyright © 2016年 GVS. All rights reserved.
//

#import "IndexViewController.h"
#import "Header.h"
@interface IndexViewController ()<ZM_MenuViewProtocol,UIWebViewDelegate>
@property (nonatomic, strong)UIWebView * webView;
@end

@implementation IndexViewController
{
    AppDelegate * app;
    UILabel * label;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (app.page < 0) {
        self.tabBarController.tabBar.hidden = NO;
        self.hidesBottomBarWhenPushed = NO;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createMenuView];
    [self createWebViewWithTag:0];
    
}
-(void)createMenuView
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    ZM_MenuView * menuView = [[ZM_MenuView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    NSArray * array = @[@"资讯",@"视频"];
    menuView.backgroundColor = [UIColor colorWithRed:45/255.0f green:42/255.0f blue:43/255.0f alpha:1.0f];
    menuView.delegate = self;
    [menuView setMenueWithArray:array];
    [self.view addSubview:menuView];
}
#pragma mark - ZM_MenuViewProtocol
-(void)createWebViewWithTag:(NSInteger)tag
{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.webView.delegate = self;
//    [self.webView scalesPageToFit];
//    self.webView.scrollView.bounces = NO;
    switch (tag) {
        case 0:
        {
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:ZIXUN]]];
            break;
        }
        case 1:
        {
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:VIDEO]]];
            break;
        }
        default:
            break;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view addSubview:self.webView];
    });
    
}
#pragma mark - UIWebViewDelegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString * string = [NSString stringWithFormat:@"%@",request.URL];
    if (![string isEqualToString:ZIXUN] && ![string isEqualToString:VIDEO]) {
        if (navigationType == UIWebViewNavigationTypeLinkClicked || navigationType == UIWebViewNavigationTypeOther) {
            app = [UIApplication sharedApplication].delegate;
            app.page = 0;
            ZM_ArticleViewController * avc = [[ZM_ArticleViewController alloc] init];
            avc.urlStr = string;
            [self.navigationController pushViewController:avc animated:YES];
            
        }
        return NO;
    }else{
        return YES;
    }
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    label.center = self.view.center;
    label.text = @"加载中...";
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    label.center = self.view.center;
    label.text = @"加载失败，请重试！";
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
#if 0
    //删除头部导航栏
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName(\"header\")[0].remove()"];
    //    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName(\"header\")[0].background-color=\"white\""];
    //头部链接
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName(\"nav\")[0].remove()"];
    //    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName(\"h-back-svg\")[0].remove()"];
    //    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName(\"h-panel\")[0].remove()"];
    //文章底部分享按钮
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName(\"bdsharebuttonbox\")[0].remove()"];
    //推荐新闻
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName(\"channel-col\")[0].remove()"];
    //推荐视频
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName(\"channel-col\")[0].remove()"];
    
    //底部导航
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName(\"foot-type\")[0].remove()"];
    //底部电脑版
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName(\"footer-panel\")[0].remove()"];
    //底部copyright
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName(\"footer-info\")[0].remove()"];
    //TOP按钮
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName(\"footer-toTop\")[0].remove()"];
    
    /*
     CGFloat sectionHeight = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName(\"main\")[0].offsetHeight"] floatValue];
     CGFloat shareHeight = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName(\"bdsharebuttonbox\")[0].offsetHeight"] floatValue];
     CGFloat chanelHeight = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName(\"channel-col\")[0].offsetHeight"] floatValue] * 2;
     
     CGRect frame = self.webView.frame;
     frame.size.height = self.view.frame.size.height / (sectionHeight-shareHeight-chanelHeight);
     self.webView.frame = frame;
     NSLog(@"%f",frame.size.height);
     */
#endif
    [label removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

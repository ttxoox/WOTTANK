//
//  ArticleViewController.m
//  WOT
//
//  Created by GVS on 16/8/31.
//  Copyright © 2016年 GVS. All rights reserved.
//

#import "ZM_ArticleViewController.h"
#import "Header.h"
//定义URL的类型，枚举
typedef enum enum_URLTYPE{
    URLisARTICLE = 0,
    URLisVIDEO
}URLTYPE;
@interface ZM_ArticleViewController ()<UIWebViewDelegate>
//@property (nonatomic, strong)UIWebView * webView;
@property (nonatomic, strong)UIWebView * webView;
@property (nonatomic, strong)UILabel * label;
@property (nonatomic, assign)URLTYPE  urlType;//判断该url是文章还是视频
@end

@implementation ZM_ArticleViewController
{
    AppDelegate * app;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createNavBar];
    [self createWebView];
   
}
-(void)createNavBar
{
    app = [UIApplication sharedApplication].delegate;
    if (app.page >= 0) {
        UIBarButtonItem * rightBarItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
        self.navigationItem.rightBarButtonItem = rightBarItem;
        self.hidesBottomBarWhenPushed = YES;
        self.tabBarController.tabBar.hidden = YES;
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftClick:)];
}
-(void)createWebView
{
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 100)];
    self.view.backgroundColor = [UIColor colorWithRed:246/255.0f green:246/255.0f blue:246/255.0f alpha:1.0f];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
    [self.view addSubview:self.webView];
    
    
}

-(void)rightItemClick
{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"alert" message:@"test" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"cancle" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:ok];
    [alertController addAction:cancle];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)leftClick:(UIBarButtonItem *)btn
{
    app.page --;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString * string = [NSString stringWithFormat:@"%@",request.URL];
    NSArray * array = [string componentsSeparatedByString:@"//"];
    if ([[[array objectAtIndex:1] substringToIndex:1] isEqualToString:@"m"]) {
        self.urlType = URLisVIDEO;
    }else{
        self.urlType = URLisARTICLE;
    }
    
    if (![string isEqualToString:self.urlStr]) {
        if (navigationType == UIWebViewNavigationTypeOther || navigationType == UIWebViewNavigationTypeLinkClicked) {
            ZM_ArticleViewController * avc = [[ZM_ArticleViewController alloc] init];
            app.page +=1;
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
    self.label.text = @"加载中，请稍候...";
    self.label.textColor = [UIColor blackColor];
//    [self.view addSubview:self.label];
//    if (app.page == 0) {
//        [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName(\"comment-post-ctn\")[0].remove()"];
//    }

}
-(void)createNavTitleView:(NSString *)title
{
//    self.navigationItem.title = title;
    UIView * titleView_make = [[UIView alloc] initWithFrame:CGRectMake(40, 0, self.view.frame.size.width, 30)];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    label.text = title;
    label.textColor = [UIColor colorWithRed:190/255.0f green:189/255.0f blue:170/255.0f alpha:1.0f];
    [titleView_make addSubview:label];
    self.navigationItem.titleView = titleView_make;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString * title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self createNavTitleView:title];
    CGFloat headerHeight;
    CGFloat navHeight;
    if (self.urlType == URLisARTICLE) {
        headerHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName(\"header\")[0].offsetHeight"] floatValue];
        navHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName(\"nav\")[0].offsetHeight"] floatValue];
        //图集顶部
        [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName(\"ui-picHeader\")[0].remove()"];

        //删除头部导航栏
        [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName(\"header\")[0].remove()"];
        //    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName(\"header\")[0].background-color=\"white\""];
        //头部链接
        [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName(\"nav\")[0].remove()"];
        
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

    }else{
        
        //资讯页面视频头部
        [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"header\").remove()"];
        //top
        [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"gotop\").remove()"];
        //
        [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"play-video-list\").remove()"];
        [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName(\"footer\")[0].remove()"];
        [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName(\"video-action\")[0].remove"];

    }
    
    CGRect frame = self.webView.frame;
    frame.origin.y = self.webView.frame.origin.y-headerHeight;
    if (app.page >0) {
        frame.size.height = self.view.frame.size.height;
    }
    self.webView.frame = frame;
    [self.label removeFromSuperview];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.label.text = @"";
    self.label.text = @"加载失败，请重试...";
    self.label.textColor = [UIColor blackColor];
    [self.label removeFromSuperview];
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

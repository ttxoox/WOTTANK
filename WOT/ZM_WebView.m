//
//  ZM_WebView.m
//  WOT
//
//  Created by GVS on 16/9/2.
//  Copyright © 2016年 GVS. All rights reserved.
//

#import "ZM_WebView.h"
#import "ZM_ArticleViewController.h"
#import "Header.h"
@implementation ZM_WebView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
        self.backgroundColor = [UIColor whiteColor];
        self.scrollView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.scrollView.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.scrollView.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
    }
    return self;
}
-(void)dealloc
{
    self.delegate = nil;
}
#pragma mark - UIWebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //    CGFloat navHeight = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName(\"nav\")[0].offsetHeight"] floatValue];
    //    CGFloat headerHeight = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName(\"header\")[0].offsetHeight"] floatValue];
    //    NSLog(@"navHeight:%f,headerHeight:%f",navHeight,headerHeight);
    //    self.webView.frame = CGRectMake(0, self.view.frame.origin.y-headerHeight*2-10, self.view.frame.size.width, self.view.frame.size.height-49);
    
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
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

}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    NSString * string = [NSString stringWithFormat:@"%@",request.URL];
//    if (![string isEqualToString:ZIXUN] && ![string isEqualToString:VIDEO]) {
//        if (navigationType == UIWebViewNavigationTypeLinkClicked || navigationType == UIWebViewNavigationTypeOther) {
//            ZM_ArticleViewController * avc = [[ZM_ArticleViewController alloc] init];
//            avc.urlStr = string;
//            [self.navigationController pushViewController:avc animated:YES];
//            
//        }
//        return NO;
//    }else{
//        return YES;
//    }

    return YES;
}
@end

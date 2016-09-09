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
@property (nonatomic, strong)UIScrollView * scrollView;
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
    //处理pn
    self.pn = [self.pn stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    ZM_MenuView * menuView = [[ZM_MenuView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    NSArray * array = @[@"战绩",@"能力",@"数据"];
    menuView.backgroundColor = [UIColor whiteColor];
    menuView.delegate = self;
    [menuView setMenueWithArray:array selectColor:[UIColor blackColor] andDeselectColor:[UIColor redColor]];
    [self.view addSubview:menuView];
    [self createWebViewWithTag:0];
}
-(void)createWebViewWithTag:(NSInteger)tag
{
   self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.webView.delegate = self;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    switch (tag) {
        case 0:
        {
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:QUEREY,self.pn,self.zone]]]];
           break;
        }
        case 1:
        {
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:ABILITY,self.pn,self.zone]]]];
            break;
        }
        case 2:
        {
        
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
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"%f",webView.frame.size.height);
    NSLog(@"%f",self.view.frame.size.height);
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@",error.localizedDescription);
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

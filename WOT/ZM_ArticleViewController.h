//
//  ArticleViewController.h
//  WOT
//
//  Created by GVS on 16/8/31.
//  Copyright © 2016年 GVS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZM_ArticleViewController : UIViewController
@property (nonatomic, copy)NSString * urlStr;
-(void)createNavTitleView:(NSString *)title;
@end

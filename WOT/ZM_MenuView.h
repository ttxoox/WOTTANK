//
//  ZM_MenuView.h
//  WOT
//
//  Created by GVS on 16/8/31.
//  Copyright © 2016年 GVS. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZM_MenuViewProtocol <NSObject>
@required
-(void)createWebViewWithTag:(NSInteger)tag;
@end

@interface ZM_MenuView : UIView

@property (nonatomic, assign)id<ZM_MenuViewProtocol> delegate;

-(void)setMenueWithArray:(NSArray *)nameArray selectColor:(UIColor *)selectColor andDeselectColor:(UIColor *)deSelectColor;

@end

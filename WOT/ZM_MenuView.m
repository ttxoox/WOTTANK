//
//  ZM_MenuView.m
//  WOT
//
//  Created by GVS on 16/8/31.
//  Copyright © 2016年 GVS. All rights reserved.
//

#import "ZM_MenuView.h"

@implementation ZM_MenuView
{
    CGFloat SPACE;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setMenueWithArray:(NSArray *)nameArray selectColor:(UIColor *)selectColor andDeselectColor:(UIColor *)deSelectColor
{
    SPACE = self.frame.size.width/7;
    for (int i=0; i<nameArray.count; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        if (button.tag == 0) {
            button.enabled = NO;
        }
        button.frame = CGRectMake(10+SPACE * i, 0, SPACE+5, self.frame.size.height);
        //select
        NSMutableAttributedString * enable = [[NSMutableAttributedString alloc] initWithString:[nameArray objectAtIndex:i]];
        [enable addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13.0f],NSForegroundColorAttributeName:selectColor} range:NSMakeRange(0, enable.length)];
        [button setAttributedTitle:enable forState:UIControlStateNormal];
        
        //diselect
        NSMutableAttributedString * unEnable = [[NSMutableAttributedString alloc] initWithString:[nameArray objectAtIndex:i]];
        [unEnable addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13.0f],NSForegroundColorAttributeName:deSelectColor} range:NSMakeRange(0, unEnable.length)];
        [button setAttributedTitle:unEnable forState:UIControlStateDisabled];
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    UIView * markView = [[UIView alloc] initWithFrame:CGRectMake(15, self.frame.size.height-2.5, SPACE-5, 3)];
    markView.tag = 999;
    markView.backgroundColor = [UIColor yellowColor];
    [self addSubview:markView];
}
-(void)buttonClick:(UIButton *)sender
{
    for (UIView * view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton * btn = (UIButton *)view;
            if (btn.tag == sender.tag) {
                btn.enabled = NO;
            }else{
                btn.enabled = YES;
            }
        }
    }
    UIView * markview = (UIView *)[self viewWithTag:999];
    [UIView animateWithDuration:0.2f animations:^{
        CGRect frame = markview.frame;
        frame.origin.x = sender.tag * SPACE+15;
        markview.frame = frame;
    }];
    if ([self.delegate respondsToSelector:@selector(createWebViewWithTag:)]) {
        [self.delegate createWebViewWithTag:sender.tag];
    }
}
@end

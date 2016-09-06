//
//  ZM_DiscoverTableViewCell.m
//  WOT
//
//  Created by GVS on 16/9/6.
//  Copyright © 2016年 GVS. All rights reserved.
//

#import "ZM_DiscoverTableViewCell.h"

@implementation ZM_DiscoverTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)updateCellWithName:(NSString *)name img:(NSString *)imgName
{
    self.titleLabel.text = name;
    self.headerImgView.image = [UIImage imageNamed:imgName];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

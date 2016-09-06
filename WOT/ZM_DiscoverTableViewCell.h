//
//  ZM_DiscoverTableViewCell.h
//  WOT
//
//  Created by GVS on 16/9/6.
//  Copyright © 2016年 GVS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZM_DiscoverTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *footerImgView;
-(void)updateCellWithName:(NSString *)name img:(NSString *)imgName;
@end

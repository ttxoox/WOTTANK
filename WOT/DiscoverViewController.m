//
//  DiscoverViewController.m
//  WOT
//
//  Created by GVS on 16/8/31.
//  Copyright © 2016年 GVS. All rights reserved.
//

#import "DiscoverViewController.h"
#import "Header.h"
@interface DiscoverViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, strong)NSMutableArray * imgArray;
@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIView * titleView_make = [[UIView alloc] initWithFrame:CGRectMake(40, 0, self.view.frame.size.width, 30)];
//    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(self.navigationItem.titleView.center.x, 0, 200, 30)];
//    label.text = @"发现";
//    label.textColor = [UIColor colorWithRed:190/255.0f green:189/255.0f blue:170/255.0f alpha:1.0f];
//    [titleView_make addSubview:label];
//    self.navigationItem.titleView = titleView_make;
    self.navigationItem.title = @"发现";
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"ZM_DiscoverTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.tableView];
    
    NSArray * row1 = @[@"查询战斗力",@"排行榜",@"我的道具"];
    NSArray * row2 = @[@"活动"];
    NSArray * img1 = @[@"battle",@"paihangbang",@"daoju"];
    NSArray * img2 = @[@"activity"];
    self.imgArray = [[NSMutableArray alloc] initWithObjects:img1,img2, nil];
    self.dataArray = [[NSMutableArray alloc] initWithObjects:row1,row2, nil];
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZM_DiscoverTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[ZM_DiscoverTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell updateCellWithName:[self.dataArray objectAtIndex:indexPath.section][indexPath.row] img:[self.imgArray objectAtIndex:indexPath.section][indexPath.row]];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor lightGrayColor];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ZM_SearchViewController * svc = [[ZM_SearchViewController alloc] init];
            svc.title = [[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:svc animated:YES];
        }
    }
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

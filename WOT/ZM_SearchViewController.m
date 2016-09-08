//
//  ZM_SearchViewController.m
//  WOT
//
//  Created by GVS on 16/9/6.
//  Copyright © 2016年 GVS. All rights reserved.
//

#import "ZM_SearchViewController.h"
#import "Header.h"
@interface ZM_SearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSMutableArray * dataList;//搜索到的列表
@end

@implementation ZM_SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.translucent = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.placeholder = @"搜索";
    self.searchBar.showsCancelButton = NO;
    self.searchBar.delegate = self;
    self.dataList = [[NSMutableArray alloc] init];
    self.navigationItem.title = self.title;
}
#pragma mark - tableviewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataList.count == 0) {
        return 0;
    }else{
        return self.dataList.count;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    if (self.dataList.count != 0) {
        cell.textLabel.text = [[self.dataList objectAtIndex:indexPath.row] objectForKey:@"pn"];
        cell.textLabel.textColor = [UIColor blackColor];
        NSNumber * zone = [[self.dataList objectAtIndex:indexPath.row] objectForKey:@"zone"];
        if ([zone intValue] == 0) {
            cell.detailTextLabel.text = @"南方电信区";
        }else{
            cell.detailTextLabel.text = @"北方联通区";
        }
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZM_DetailViewController * dvc = [[ZM_DetailViewController alloc] init];
    dvc.dataDict = [self.dataList objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:dvc animated:YES];
}
#pragma mark - searchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
    [searchBar resignFirstResponder];
    self.searchBar.text = nil;
    self.searchBar.showsCancelButton = NO;
    [self.dataList removeAllObjects];
    [self.tableView reloadData];
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.searchBar.showsCancelButton = YES;
    for (UIView * view in [[[self.searchBar subviews] objectAtIndex:0] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton * button = (UIButton *)view;
            [button setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.dataList removeAllObjects];
    NSDictionary * paramDict = @{@"pn":searchText};
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager POST:SEARCHLIST parameters:paramDict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray * array = dict[@"data"];
        for (NSDictionary * responseDict in array) {
            [self.dataList addObject:responseDict];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"%@",[error localizedDescription]);
    }];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    self.searchBar.showsCancelButton = NO;
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

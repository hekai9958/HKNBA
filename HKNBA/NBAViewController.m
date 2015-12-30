//
//  NBAViewController.m
//  HKNBA
//
//  Created by qianfeng on 15/12/17.
//  Copyright © 2015年 贺凯. All rights reserved.
//

#import "NBAViewController.h"
#import "AppDelegate.h"
#import <MJRefresh/MJRefresh.h>
#import <AFNetworking/AFNetworking.h>
#import "HKNBATableViewCell.h"
#import "HKNBAModel.h"
#import "HKViewController.h"
#import <UIImageView+WebCache.h>
#import "RelateViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#define URL @"http://c.3g.163.com/nc/article/list/T1348649145984/%ld0-20.html"

@interface NBAViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView*_tableView;
    NSMutableArray*_dataSource;
    UIImageView*_imageView;
    MJRefreshNormalHeader*_header;
    MJRefreshBackNormalFooter*_footer;
}
@end

@implementation NBAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [NSMutableArray array];
    [self createTableView];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"头"] forBarMetrics:0];
    [self addRightNavgationItem:@"更多应用"];
    [self addLeftNavgationItem:@"刷新"];
}
//左边更多应用
-(void)addRightNavgationItem:(NSString *)title{
    UIButton*button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 80, 30);
    [button setBackgroundImage:[UIImage imageNamed:@"quxiao"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButtonItem;
}
//进入跟多应用
-(void)buttonAction:(UIButton*)button{
    RelateViewController*rvc = [RelateViewController new];
    [self.navigationController pushViewController:rvc animated:YES];
}
//右边刷新列表
-(void)addLeftNavgationItem:(NSString*)title{
    UIButton*button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 50, 30);
    [button setBackgroundImage:[UIImage imageNamed:@"quxiao"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(button2Action:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}
//刷新列表点击时间
-(void)button2Action:(UIButton*)button{
    //显示loading提示框
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    MJRefreshNormalHeader*header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//       [self loadDataFromNet:NO];
//    }];
//    _tableView.mj_header = header;
    [_tableView.mj_header beginRefreshing];
}
//创建头视图
-(void)createImageView{
    _imageView = [[UIImageView alloc]init];
    CGSize size = self.view.frame.size;
    _imageView.frame = CGRectMake(0, 0, size.width, size.height/4+40);
    T1Model*model1 = _dataSource[1];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model1.imgsrc]];
    //添加手势
    UITapGestureRecognizer*tgr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tgrAction:)];
    _imageView.userInteractionEnabled = YES;
    [_imageView addGestureRecognizer:tgr];
}
-(void)tgrAction:(UITapGestureRecognizer*)tgr{
    HKViewController*nba = [[HKViewController alloc]init];
    T1Model*model = _dataSource[1];
    nba.docidString = model.docid;
    nba.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nba animated:YES];
}
//-(void)button1Action:(UIButton*)button{
//    NSString *number = @"13525411424";// 此处读入电话号码
//    // NSString *num = [[NSString alloc]initWithFormat:@"tel://%@",number]; //number为号码字符串 如果使用这个方法结束电话之后会进入联系人列表
//    
//    NSString *num = [[NSString alloc]initWithFormat:@"telprompt://%@",number]; //而这个方法则打电话前先弹框 是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
//}
//-(void)button2Action:(UIButton*)button{
//    HKSetViewController*vc = [HKSetViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
//}
-(void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44) style:UITableViewStylePlain];
    _tableView.dataSource =self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    _header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataFromNet:NO];
    }];
    _tableView.mj_header = _header;
    _footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadDataFromNet:YES];
    }];
    _tableView.mj_footer = _footer;
    [_tableView.mj_header beginRefreshing];
}
-(void)loadDataFromNet:(BOOL)isMore{
    NSInteger page = 1;
    if (isMore) {
        if (_dataSource.count%20 == 0) {
            page = _dataSource.count/20;
        }
    }
    //显示loading提示框
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString*url = [NSString stringWithFormat:URL,page];
    AFHTTPRequestOperationManager*manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"%@",responseObject);
        if (!isMore) {
            [_dataSource removeAllObjects];
            [_tableView reloadData];
        }
        HKNBAModel*model = [[HKNBAModel alloc]initWithData:responseObject error:nil];
        for (T1Model*model1 in model.T1348649145984) {
            [_dataSource addObject:model1];
            //NSLog(@"%@",_dataSource);
        }
        [_tableView reloadData];
        [self createImageView];
        //创建头视图
        _tableView.tableHeaderView = _imageView;
        //隐藏loading 提示框
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        isMore?[_tableView.mj_footer endRefreshing]:[_tableView.mj_header endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        isMore?[_tableView.mj_footer endRefreshing]:[_tableView.mj_header endRefreshing];
        //隐藏loading 提示框
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}
#pragma mark - 代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HKViewController*vc = [HKViewController new];
    T1Model*model = _dataSource[indexPath.row];
    vc.docidString = model.docid;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(HKNBATableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    T1Model*model1 = _dataSource[indexPath.row];
    if (model1.imgextra) {
        static NSString*cellID1 = @"cellId1";
        HKNBATableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
        if (cell == nil) {
            cell = [[HKNBATableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
        }
        if (indexPath.row%2) {
            cell.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:239/255.0 alpha:1.0];
        }else{
            cell.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
        }
        cell.backgroundColor = [UIColor lightTextColor];
        [cell updateDataWithModel:model1];
        return cell;
    }else{
        static NSString*cellID2 = @"cellId2";
        HKNBATableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:cellID2];
        if (cell == nil) {
            cell = [[HKNBATableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];
        }
        if (indexPath.row%2) {
            cell.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:239/255.0 alpha:1.0];
        }else{
            cell.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
        }
        [cell updateDataWithModel:model1];
        return cell;
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

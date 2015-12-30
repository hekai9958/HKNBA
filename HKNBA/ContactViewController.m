//
//  ContactViewController.m
//  HKNBA
//
//  Created by qianfeng on 15/12/17.
//  Copyright © 2015年 贺凯. All rights reserved.
//

#import "ContactViewController.h"
#import "RelateViewController.h"
#import <MJRefresh/MJRefresh.h>
#import <AFNetworking/AFNetworking.h>
#import "HKNBAModel.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "HKCollectionViewCell.h"
#import "HKTGRViewController.h"
#define URL @"http://c.3g.163.com/nc/article/list/T1348649145984/%ld0-20.html"

@interface ContactViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView*_collectionView;
    NSMutableArray*_dataSource;
    MJRefreshNormalHeader*_header;
    MJRefreshBackNormalFooter*_footer;
}
@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [[NSMutableArray alloc]init];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"头"] forBarMetrics:0];
    [self createCollectionView];
    [self addRightNavgationItem:@"更多应用"];
    [self addLeftNavgationItem:@"刷新"];
}

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
-(void)buttonAction:(UIButton*)button{
    RelateViewController*rvc = [RelateViewController new];
    [self.navigationController pushViewController:rvc animated:YES];
}
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
//刷新键
-(void)button2Action:(UIButton*)button{
    //显示loading提示框
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [_collectionView.mj_header beginRefreshing];
    
}
//-(void)createButtonAndLabel{
//    CGSize size = self.view.frame.size;
//    UILabel*label = [[UILabel alloc]init];
//    label.text = @"篮球热联盟（Basketball Information 简称：BI）是一个面向校园的篮球联盟。BI旨在打造一个最简单便捷的篮球资讯浏览，倡导校园篮球文化，活跃校园篮球氛围，解决校园篮球3低问题---篮球水平整体低，球迷关注度低，球员参与度低，促进学校的球迷建设；通过对篮球相关活动的软件+硬件以及资金扶持，推动和促进各学校球迷活动的发展和普及，营造学校球迷的文化氛围，使同学们的课余生活更加丰富多彩，为校园篮球的发展作出应有的贡献。我们的宗旨是：让更多人关注校园篮球，让更多同学回到球场。";
//    label.numberOfLines = 0;
//    label.frame = CGRectMake(0, 0,size.width,300);
//    UIButton*button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitle:@"电话:13525411424" forState:UIControlStateNormal];
//    button.frame = CGRectMake(0, 300+30, 180, 20);
//    button.showsTouchWhenHighlighted = YES;
//    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(button1Action:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:label];
//    [self.view addSubview:button];
//}
//-(void)button1Action:(UIButton*)button{
//    NSString *number = @"13525411424";// 此处读入电话号码
//    // NSString *num = [[NSString alloc]initWithFormat:@"tel://%@",number]; //number为号码字符串 如果使用这个方法结束电话之后会进入联系人列表
//
//    NSString *num = [[NSString alloc]initWithFormat:@"telprompt://%@",number]; //而这个方法则打电话前先弹框 是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
//}

//-------------------------------------collectionView----------------------------------
-(UICollectionViewFlowLayout*)createLayout{
    UICollectionViewFlowLayout*layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 10;
    layout.itemSize = CGSizeMake(self.view.frame.size.width/2-10, 150);
    layout.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5);
    return layout;
}
-(void)createCollectionView{
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:[self createLayout]];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[HKCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    [self.view addSubview:_collectionView];
    _header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadDataFromNet:NO];
    }];
    _collectionView.mj_header = _header;
    _footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadDataFromNet:YES];
    }];
    _collectionView.mj_footer = _footer;
    [_collectionView.mj_header beginRefreshing];
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
        if (!isMore) {
            [_dataSource removeAllObjects];
            [_collectionView reloadData];
        }
        HKNBAModel *model = [[HKNBAModel alloc]initWithData:responseObject error:nil];
        for (T1Model*model1 in model.T1348649145984) {
            [_dataSource addObject:model1];
        }
        [_collectionView reloadData];
        
        //隐藏loading 提示框
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        isMore?[_collectionView.mj_footer endRefreshing]:[_collectionView.mj_header endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        isMore?[_collectionView.mj_footer endRefreshing]:[_collectionView.mj_header endRefreshing];
        //隐藏loading 提示框
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}
#pragma mark - UICollectionViewDataSource
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HKTGRViewController*tvc = [HKTGRViewController new];
    tvc.index = indexPath.row;
    tvc.dataArray = _dataSource;
    tvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tvc animated:YES];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HKCollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    T1Model*model1 = _dataSource[indexPath.row];
    [cell updateDataWithModel:model1];
    return cell;
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

























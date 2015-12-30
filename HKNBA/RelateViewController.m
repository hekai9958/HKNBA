//
//  RelateViewController.m
//  HKNBA
//
//  Created by qianfeng on 15/12/18.
//  Copyright © 2015年 贺凯. All rights reserved.
//

#import "RelateViewController.h"
#define MINHU @"https://itunes.apple.com/cn/app/min-hu-yun-dong/id1014295076?mt=8"
#define QIUTAN @"https://itunes.apple.com/cn/app/qiu-tan-lan-qiu-bi-fen/id542277866?mt=8"
#define XUN @"https://itunes.apple.com/cn/app/xun-qiu-zu-qiu-ai-hao-zhe/id990928336?mt=8"
#define XUEQIU @"https://itunes.apple.com/cn/app/diao-yu-ren-zhuan-wei-diao/id1028971150?mt=8"
#define YUNDONG @"https://itunes.apple.com/cn/app/qu-yun-dong-yu-mao-qiu-zu/id717619906?mt=8"
#define GOSKI @"https://itunes.apple.com/cn/app/goski-qu-hua-xue-zhao-hua/id1022225115?mt=8"
#define DIAOYU @"https://itunes.apple.com/cn/app/diao-yu-ren-zhuan-wei-diao/id1028971150?mt=8"
#define CAIQIU @"https://itunes.apple.com/cn/app/cai-qiu-zu-cai-lan-cai-yu/id978242979?mt=8"

@interface RelateViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView*_tableView;
}
@end

@implementation RelateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"头"] forBarMetrics:0];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
    [self createNavigation];
}
-(void)createNavigation{
    UIImage *image1 = [[UIImage imageNamed:@"0000"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem*leftItem = [[UIBarButtonItem alloc]initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(popLastViewController:)];
    self.navigationItem.leftBarButtonItem = leftItem;
}
-(void)popLastViewController:(UIBarButtonItem*)item{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource =self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:MINHU]];
            break;
        case 1:
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:QIUTAN]];
            break;
        case 2:
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:XUN]];
            break;
        case 3:
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:XUEQIU]];
            break;
        case 4:
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:YUNDONG]];
            break;
        case 5:
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:GOSKI]];
            break;
        case 6:
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:DIAOYU]];
            break;
        case 7:
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:CAIQIU]];
            break;
            
        default:
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*cellID = @"cellId";
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    NSArray*imageNames = @[@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13"];
    NSArray*titles = @[@"敏狐运动",@"球探篮球比分",@"寻球:足球爱好者的平台",@"学打篮球-最全面的篮球技术教程",@"趣运动-羽毛球,足球,篮球订场神器",@"GoSki(去滑雪)",@"钓鱼人-专为钓鱼人打造,国内最火钓鱼神器",@"彩球:足彩篮彩预测专家"];
    UIImage*image = [UIImage imageNamed:imageNames[indexPath.row]];
    cell.imageView.image = image;
    cell.textLabel.text = titles[indexPath.row];
    
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

























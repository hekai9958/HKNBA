//
//  SetViewController.m
//  HKNBA
//
//  Created by qianfeng on 15/12/17.
//  Copyright © 2015年 贺凯. All rights reserved.
//

#import "SetViewController.h"
#import "HKMoreViewController.h"
#import "RelateViewController.h"
#import <UMengSocial/UMSocial.h>

@interface SetViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView*_imageView;
    UITableView*_tableView;
    NSDictionary*_info;
}
@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"头"] forBarMetrics:0];
    [self createImageView];
    [self createTableView];
    [self addRightNavgationItem:@"更多应用"];
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
    
    UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}
-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, _imageView.frame.size.width, _imageView.frame.size.height) style:UITableViewStylePlain];
    _tableView.dataSource =self;
    _tableView.delegate = self;
    _tableView.layer.cornerRadius = 10;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tableFooterView = [UIView new];
    [_imageView addSubview:_tableView];
}
#pragma mark - 代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            [self threeShare];
        }

            break;
        case 1:{
            UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"⚠️" message:@"这是一款最新的APP,简单好用" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
            [alert show];
        }
            break;
        case 2:{
            UMSocialData*socialData = [[UMSocialData alloc]initWithIdentifier:@"identifier"];
            UMSocialControllerServiceComment*socialControllerService = [[UMSocialControllerServiceComment alloc]initWithUMSocialData:socialData];
            UINavigationController*commentList = [socialControllerService getSocialCommentListController];
            [self presentModalViewController:commentList animated:YES];
        }
//    NSArray*title = @[@"二维码",@"软件卸载",@"分享软件",@"关于软件",@"意见反馈"];
            break;
            
        default:
            break;
    }
    
}
//分享
-(void)threeShare{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5677664e67e58e781900026f"
                                      shareText:@"这是一款很厉害的App"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToRenren,UMShareToDouban,UMShareToEmail,UMShareToSms,UMShareToFacebook,UMShareToTencent,nil]
                                       delegate:nil];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _imageView.frame.size.height/6;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*cellID = @"cellId";
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    NSArray*array = @[@"fenxiang",@"guanyu",@"yijian"];
    NSArray*title = @[@"分享软件",@"关于软件",@"意见反馈"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    cell.layer.cornerRadius = 10;
    
    UIImage*image = [UIImage imageNamed:array[indexPath.row]];
    cell.imageView.image = image;
    cell.textLabel.text = title[indexPath.row];
    return cell;
}
-(void)createImageView{
    CGSize size = self.view.frame.size;
    UIImage*image = [UIImage imageNamed:@"appdetail_background"];
    _imageView = [[UIImageView alloc] initWithImage:image];
    _imageView.userInteractionEnabled = YES;
    _imageView.frame = CGRectMake(10, 0, size.width-20, size.height/2);
    
    [self.view addSubview:_imageView];
}
-(void)createNavigationItem{
    //UIImage *image = [[UIImage imageNamed:@"cog"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIBarButtonItem*leftItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
}
-(void)rightItemAction:(UIBarButtonItem*)rightItem{
    
}
-(void)leftItemAction:(UIBarButtonItem*)leftItem{
    [self.navigationController popViewControllerAnimated:YES];
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































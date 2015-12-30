//
//  HKCBAViewController.m
//  HKNBA
//
//  Created by qianfeng on 15/12/18.
//  Copyright © 2015年 贺凯. All rights reserved.
//

#import "HKCBAViewController.h"
#import "CBAWebModel.h"
#import <AFNetworking/AFNetworking.h>
#import <UMengSocial/UMSocial.h>

#define DETAILURL @"http://c.m.163.com/nc/article/%@/full.html"

@interface HKCBAViewController ()<UIWebViewDelegate>

@property(nonatomic,copy)UIWebView*webView;
@property(nonatomic,copy)UIActivityIndicatorView*activityIndicatorView;
@property(nonatomic,strong)CBAWebModel *webModel;

@end

@implementation HKCBAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createWebView];
    [self loadDataFromNet];
//    [self createNavigation];
    [self addRightNavgationItem:@""];
    [self addLeftNavgationItem:@"分享"];
}
//左边更多应用
-(void)addRightNavgationItem:(NSString *)title{
    UIButton*button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 50, 30);
    [button setBackgroundImage:[UIImage imageNamed:@"0000"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButtonItem;
}
-(void)buttonAction:(UIButton*)button{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//分享设置
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
-(void)button2Action:(UIButton*)button{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5677664e67e58e781900026f"
                                      shareText:@"这是一款很厉害的App"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToRenren,UMShareToDouban,UMShareToEmail,UMShareToSms,UMShareToFacebook,UMShareToTencent,nil]
                                       delegate:nil];
}
-(void)createNavigation{
    UIImage *image1 = [[UIImage imageNamed:@"0000"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem*leftItem = [[UIBarButtonItem alloc]initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(popLastViewController:)];
    self.navigationItem.leftBarButtonItem = leftItem;
}
-(void)popLastViewController:(UIBarButtonItem*)item{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createWebView{
    _webView = [[UIWebView alloc]init];
    _webView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64);
    _webView.scalesPageToFit = YES;
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc]init];
    [_activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicatorView.frame = CGRectMake(0, 0, 32, 32);
    _activityIndicatorView.center = self.view.center;
    [self.view addSubview:_activityIndicatorView];
}
-(void)loadDataFromNet{
    NSString*url = [NSString stringWithFormat:DETAILURL,_docidString];
    AFHTTPRequestOperationManager*manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //根据docid来取值
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary * dict2 = dict[_docidString];
        //NSLog(@"%@",dict2);
        _webModel = [[CBAWebModel alloc]initWithDictionary:dict2 error:nil];
        [self webLoadHTML];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
- (void)webLoadHTML {
    //设置cell进去内容
    NSString * time = [NSString stringWithFormat:@"%@%@",_webModel.ptime,_webModel.source];
    NSString * image1= nil;
    NSString * formatString = nil;
    NSString * contentStr  = nil;
    if (_webModel.img.count!=0) {
        CbaImgModel * imgModel = _webModel.img[0];
        image1=[NSString stringWithFormat:@"<img src='%@'  height='700' width='990'/>",imgModel.src];
        
        formatString = @"<span style=\"font-size:40px;color:#7E7C8A\"><p  class=\"title\">%@ &nbsp</p><p>%@</p><p>%@</p></span>";
        contentStr = [NSString stringWithFormat:formatString,time,image1,_webModel.body];
        
    }else{
        formatString = @"<span style=\"font-size:40px;color:#7E7C8A\"><p class=\"title\">%@ &nbsp</p><p>%@</p></span>";
        contentStr = [NSString stringWithFormat:formatString,time,_webModel.body];
    }
    //webview 怎么改变字体大小， 怎么添加图片
    [_webView loadHTMLString:contentStr baseURL:nil];
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [_activityIndicatorView startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [_activityIndicatorView stopAnimating];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

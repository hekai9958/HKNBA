//
//  HKMoreViewController.m
//  HKNBA
//
//  Created by qianfeng on 15/12/18.
//  Copyright © 2015年 贺凯. All rights reserved.
//

#import "HKMoreViewController.h"
#import <UMengSocial/UMSocial.h>

@interface HKMoreViewController ()<UMSocialUIDelegate,UIAlertViewDelegate>

@end

@implementation HKMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createMoreThings];
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

-(void)createMoreThings{
    switch (_index) {
        case 0:
            [self threeShare];
            break;
        case 1:
            
            break;
        case 2:
            [self fiveIdea];
            break;
            
        default:
            break;
    }
}
-(void)threeShare{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5677664e67e58e781900026f"
                                      shareText:@"这是一款很厉害的App"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToRenren,UMShareToDouban,UMShareToEmail,UMShareToSms,UMShareToFacebook,UMShareToTencent,nil]
                                       delegate:nil];
}
-(void)fiveIdea{
    UMSocialData*socialData = [[UMSocialData alloc]initWithIdentifier:@"identifier"];
    UMSocialControllerServiceComment*socialControllerService = [[UMSocialControllerServiceComment alloc]initWithUMSocialData:socialData];
    UINavigationController*commentList = [socialControllerService getSocialCommentListController];
    [self presentModalViewController:commentList animated:YES];
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

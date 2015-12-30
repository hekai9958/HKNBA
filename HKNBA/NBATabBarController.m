//
//  NBATabBarController.m
//  HKNBA
//
//  Created by qianfeng on 15/12/17.
//  Copyright © 2015年 贺凯. All rights reserved.
//

#import "NBATabBarController.h"

@interface NBATabBarController ()

@end

@implementation NBATabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createViewControllers];
    [self createSplashView];
    UIImage *tabbarimage=[UIImage imageNamed:@"bg@2x"];
    
    UIImageView *tabBarBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.tabBar.frame.size.width, self.tabBar.frame.size.height)];
    tabBarBackgroundImageView.image =tabbarimage;
    [self.tabBar insertSubview:tabBarBackgroundImageView atIndex:0];
    //self.tabBar.frame = CGRectMake(0, self.view.frame.size.height-64, self.view.frame.size.width, 100);
    //self.tabBarController.tabBar.backgroundImage = [UIImage imageNamed:@"bg@2x"];
}
-(void)createViewControllers{
    NSMutableArray*controllers = [NSMutableArray array];
    NSArray*array = @[@"NBAViewController",@"CBAViewController",@"ContactViewController",@"SetViewController"];
    NSArray*imageNames = @[@"home",@"fav",@"his",@"setting"];
    NSArray*selectImageNames = @[@"home",@"fav",@"his",@"setting"];
    NSArray*title = @[@"NBA头条",@"CBA头条",@"图片浏览",@"设置"];
    for (NSInteger i = 0;  i < array.count; i++) {
        NSString*name = array[i];
        Class class = NSClassFromString(name);
        UIViewController*vc = [[class alloc]init];
        
        UIImage *normalImage = [[UIImage imageNamed:imageNames[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIImage *selectedImage = [[UIImage imageNamed:selectImageNames[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.image = normalImage;
        vc.tabBarItem.selectedImage = selectedImage;
        vc.tabBarItem.title = title[i];
        vc.navigationItem.title = title[i];
        
        UINavigationController*nc = [[UINavigationController alloc]initWithRootViewController:vc];
        [controllers addObject:nc];
    }
    self.viewControllers = controllers;
}
-(void)createSplashView{
    UIImageView*imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    NSString*splashPath = [[NSBundle mainBundle]pathForResource:@"Default" ofType:@"png"];
    imageView.image = [[UIImage alloc]initWithContentsOfFile:splashPath];
    [self.view addSubview:imageView];
    [UIView animateWithDuration:3 animations:^{
        imageView.alpha = 0.0;
        imageView.transform = CGAffineTransformMakeScale(2, 2);
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
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

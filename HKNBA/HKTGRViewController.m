//
//  HKTGRViewController.m
//  HKNBA
//
//  Created by qianfeng on 15/12/22.
//  Copyright © 2015年 贺凯. All rights reserved.
//

#import "HKTGRViewController.h"
#import <UIImageView+WebCache.h>
#import "HKNBAModel.h"
#define VIEW_WIDTH self.view.frame.size.width
#define VIEW_HEIGHT self.view.frame.size.height
@interface HKTGRViewController ()<UIScrollViewDelegate>
{
    UIScrollView*_scrollView;
    UIPageControl*_pageControl;
    //用于保存滚动使用的图片的名字
    NSMutableArray *_imageNames;
    //用于保存循环复用的三个图片视图
    NSMutableArray *_imageViews;
}
@end

@implementation HKTGRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageNames = [NSMutableArray array];
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self createImageNames];
    [self createScrollView];
    [self createPageControl];
    [self createImageViews];
    [self addRightNavgationItem:@""];
}
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
-(void)createImageNames{
    for (T1Model*model in _dataArray) {
        [_imageNames addObject:model.imgsrc];
    }
}
-(void)createScrollView{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = self.view.frame;
    _scrollView.backgroundColor = [UIColor grayColor];
    
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    //设置内容尺寸
    _scrollView.contentSize = CGSizeMake(VIEW_WIDTH*3, VIEW_HEIGHT);
    //设置按页滚动
    _scrollView.pagingEnabled = YES;
    //设置内容偏移量
    _scrollView.contentOffset = CGPointMake(VIEW_WIDTH, 0);
    //设置代理
    _scrollView.delegate = self;
    
    [self.view addSubview:_scrollView];
}

- (void)createImageViews
{
    _imageViews = [[NSMutableArray alloc] init];
    
    //创建三个循环复用的图片视图
    for (NSUInteger i=0; i<3; i++) {
        UIImageView *view = [[UIImageView alloc] init];
        view.backgroundColor = [UIColor blackColor];
        view.frame = CGRectMake(i*VIEW_WIDTH, 0, VIEW_WIDTH, VIEW_HEIGHT);
        //设置内容填充模式
        view.contentMode = UIViewContentModeScaleAspectFit;
        //计算图片的下标，并用tag记录
        view.tag = (NSInteger)(_index+i-1+_imageNames.count)%_imageNames.count;
        //调用方法为图片视图添加图片
        [self setImageToView:view];
        //添加到滚动视图上
        [_scrollView addSubview:view];
        //保存到数组中
        [_imageViews addObject:view];
    }
}

- (void)createPageControl
{
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.frame = CGRectMake(0, VIEW_HEIGHT-50, VIEW_WIDTH, 50);
    
    _pageControl.numberOfPages = _imageNames.count;
    _pageControl.pageIndicatorTintColor = [UIColor blueColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor yellowColor];
    //添加事件
    [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_pageControl];
}

- (void)changePage:(UIPageControl *)pageControl
{
    NSInteger currentPage = pageControl.currentPage;
    if (currentPage == [_imageViews[2] tag]
        || currentPage == _imageNames.count-1) {
        //向左滑?
        CGPoint offset = CGPointMake(2*VIEW_WIDTH, 0);
        [_scrollView setContentOffset:offset animated:YES];
    } else if (currentPage == [_imageViews[0] tag]
               || currentPage == 0) {
        //向右滑
        [_scrollView setContentOffset:CGPointZero animated:YES];
    }
}

- (void)setImageToView:(UIImageView *)view
{
    [view sd_setImageWithURL:[NSURL URLWithString:_imageNames[view.tag]]];
}

- (void)cycleReuse
{
    int flag = 0;
    //获取滚动视图偏移量
    CGFloat offsetX = _scrollView.contentOffset.x;
    if (offsetX == 2*VIEW_WIDTH) {
        //向左滑
        flag = 1;
    } else if (offsetX == 0) {
        //向右滑
        flag = -1;
    } else {
        return;
    }
    //更新图片
    for (UIImageView *view in _imageViews) {
        //重新计算图片下标
        view.tag = (view.tag+flag+_imageNames.count)%_imageNames.count;
        [self setImageToView:view];
    }
    //无动画的设置偏移量为初始值
    _scrollView.contentOffset = CGPointMake(VIEW_WIDTH, 0);
    //更新pageControl的当前页码
    _pageControl.currentPage = [_imageViews[1] tag];
}

#pragma mark - 代理方法

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self cycleReuse];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self cycleReuse];
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
































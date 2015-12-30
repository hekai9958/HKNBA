//
//  HKCollectionViewCell.m
//  HKNBA
//
//  Created by qianfeng on 15/12/22.
//  Copyright © 2015年 贺凯. All rights reserved.
//

#import "HKCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import "HKTGRViewController.h"

@implementation HKCollectionViewCell
{
    UIImageView*_imageView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.contentView addSubview:_imageView];
    }
    return self;
}

-(void)updateDataWithModel:(T1Model*)model{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
}

@end











































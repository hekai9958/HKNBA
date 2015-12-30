//
//  HKCBATableViewCell.m
//  HKNBA
//
//  Created by qianfeng on 15/12/18.
//  Copyright © 2015年 贺凯. All rights reserved.
//

#import "HKCBATableViewCell.h"
#import <UIImageView+WebCache.h>

@interface HKCBATableViewCell()
{   //一张图片的cell
    UIImageView*_imgsrcView;
    UILabel*_titleLabel;
    UILabel*_contentLabel;
    UILabel*_tieLable;
    //三张图片的cell
    UIImageView*_imageView1;
    UIImageView*_imageView2;
    UIImageView*_imageView3;
    UILabel*_specialTitleLabel;
    UILabel*_tie2Label;
    NSArray*_array;
    CBAT1Model*_model;
}

@end

@implementation HKCBATableViewCell

- (void)awakeFromNib {
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ([reuseIdentifier isEqualToString:@"cellId1"]) {
        _imageView1 = [UIImageView new];
        _imageView2 = [UIImageView new];
        _imageView3 = [UIImageView new];
        _tie2Label = [UILabel new];
        _tie2Label.adjustsFontSizeToFitWidth = YES;
        _tie2Label.textColor = [UIColor lightGrayColor];
        _specialTitleLabel = [UILabel new];
        _specialTitleLabel.font = [UIFont boldSystemFontOfSize:18];
        
        _model = [CBAT1Model new];
        
        [self.contentView addSubview:_imageView1];
        [self.contentView addSubview:_imageView2];
        [self.contentView addSubview:_imageView3];
        [self.contentView addSubview:_tie2Label];
        [self.contentView addSubview:_specialTitleLabel];
        _array = @[_imageView1,_imageView2,_imageView3];
    }else{
        _imgsrcView = [UIImageView new];
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _contentLabel = [UILabel new];
        _contentLabel.numberOfLines = 0;
        _tieLable = [UILabel new];
        _tieLable.textColor = [UIColor lightGrayColor];
        _tieLable.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_imgsrcView];
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_contentLabel];
        [self.contentView addSubview:_tieLable];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat pading = 5.0;
    CGSize size = self.contentView.frame.size;
    if ([self.reuseIdentifier isEqualToString:@"cellId1"]) {
        _specialTitleLabel.frame = CGRectMake(pading, pading, size.width-2*pading-100, 20);
        _tie2Label.frame = CGRectMake(CGRectGetMaxX(_specialTitleLabel.frame)+pading, pading, size.width-3*pading-_specialTitleLabel.frame.size.width, 20);
        CGFloat width = (size.width-4*pading)/3;
        CGFloat height = size.height-_specialTitleLabel.frame.size.height-2*pading;
        [_array[0] setFrame:CGRectMake(pading, CGRectGetMaxY(_specialTitleLabel.frame), width,height)];
        [_array[0] sd_setImageWithURL:[NSURL URLWithString:_model.imgsrc] placeholderImage:[UIImage imageNamed:@"dengdaijiazai"]];
        for (NSInteger i = 0; i < _model.imgextra.count; i++) {
            [_array[i+1] setFrame:CGRectMake(pading+(pading+width)*(i+1), CGRectGetMaxY(_specialTitleLabel.frame), width, height)];
            [_array[i+1] sd_setImageWithURL:[NSURL URLWithString:[_model.imgextra[i] imgsrc]] placeholderImage:[UIImage imageNamed:@"dengdaijiazai"]];
        }
    }else if([self.reuseIdentifier isEqualToString:@"cellId2"]){
        if (![_model.imgsrc isEqualToString:@""]) {
            _imgsrcView.frame = CGRectMake(pading, pading, 80, 80);
            _titleLabel.frame = CGRectMake(CGRectGetMaxX(_imgsrcView.frame)+pading, pading, size.width-3*pading-_imgsrcView.frame.size.width, 20);
            _contentLabel.frame = CGRectMake(CGRectGetMaxX(_imgsrcView.frame)+pading, CGRectGetMaxY(_titleLabel.frame), size.width-3*pading-_imgsrcView.frame.size.width, _imgsrcView.frame.size.height-pading-_titleLabel.frame.size.height);
            _tieLable.frame = CGRectMake(_contentLabel.frame.size.width-80, _contentLabel.frame.size.height-20, 80, 20);
            [_contentLabel addSubview:_tieLable];
        }else{
            _imgsrcView.frame = CGRectZero;
            _titleLabel.frame = CGRectMake(pading, pading, size.width-10, 20);
            _contentLabel.frame = CGRectMake(pading, CGRectGetMaxY(_titleLabel.frame)+pading,size.width-10 , size.height-3*pading-_titleLabel.frame.size.height);
            _tieLable.frame = CGRectMake(_contentLabel.frame.size.width-80, _contentLabel.frame.size.height-20, 80, 20);
            [_contentLabel addSubview:_tieLable];
        }

    }
}
-(void)updateDataWithModel:(CBAT1Model*)model{
    _titleLabel.text = model.title;
    _contentLabel.text = model.digest;
    _specialTitleLabel.text = model.title;
    _tieLable.text = [NSString stringWithFormat:@"%@跟帖",model.votecount];
    _tie2Label.text = [NSString stringWithFormat:@"%@跟帖",model.votecount];
    [_imgsrcView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:[UIImage imageNamed:@"dengdaijiazai"]];
    
    _model = model;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end















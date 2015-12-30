//
//  HKCollectionViewCell.h
//  HKNBA
//
//  Created by qianfeng on 15/12/22.
//  Copyright © 2015年 贺凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKNBAModel.h"
@interface HKCollectionViewCell : UICollectionViewCell

-(void)updateDataWithModel:(T1Model*)model;

@end

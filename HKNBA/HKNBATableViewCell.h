//
//  HKNBATableViewCell.h
//  HKNBA
//
//  Created by qianfeng on 15/12/18.
//  Copyright © 2015年 贺凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKNBAModel.h"

@interface HKNBATableViewCell : UITableViewCell
-(void)updateDataWithModel:(T1Model*)model;
@end

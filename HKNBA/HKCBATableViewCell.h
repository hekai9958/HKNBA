//
//  HKCBATableViewCell.h
//  HKNBA
//
//  Created by qianfeng on 15/12/18.
//  Copyright © 2015年 贺凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKCBAModel.h"

@interface HKCBATableViewCell : UITableViewCell

-(void)updateDataWithModel:(CBAT1Model*)model;

@end

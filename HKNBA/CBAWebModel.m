//
//  CBAWebModel.m
//  HKNBA
//
//  Created by qianfeng on 15/12/18.
//  Copyright © 2015年 贺凯. All rights reserved.
//

#import "CBAWebModel.h"

@implementation CbaSysModel
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"myId"}];
}
@end


@implementation CbaSearchModel

@end

@implementation CbaImgModel

@end

@implementation CbaNewsModel
@end


@implementation CBAWebModel
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"template":@"temp"}];
}
@end

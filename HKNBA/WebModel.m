//
//  WebModel.m
//  HKNBA
//
//  Created by qianfeng on 15/12/18.
//  Copyright © 2015年 贺凯. All rights reserved.
//

#import "WebModel.h"

@implementation SysModel
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"myId"}];
}
@end


@implementation SearchModel

@end

@implementation ImgModel

@end

@implementation NewsModel
@end


@implementation WebModel
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"template":@"temp"}];
}
@end

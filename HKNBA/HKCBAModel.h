//
//  HKCBAModel.h
//  HKNBA
//
//  Created by qianfeng on 15/12/18.
//  Copyright © 2015年 贺凯. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol CBAImgextraModel
@end

@interface CBAImgextraModel : JSONModel
@property(nonatomic,copy)NSString*imgsrc;
@end

@protocol CBAT1Model
@end
@interface CBAT1Model : JSONModel

@property(nonatomic,copy)NSString<Optional>*hasCover;
@property(nonatomic,copy)NSString<Optional>*hasHead;
@property(nonatomic,copy)NSString<Optional>*replyCount;
@property(nonatomic,copy)NSString<Optional>*hasImg;
@property(nonatomic,copy)NSString<Optional>*digest;
@property(nonatomic,copy)NSString<Optional>*hasIcon;
@property(nonatomic,copy)NSString<Optional>*docid;
@property(nonatomic,copy)NSString<Optional>*title;
@property(nonatomic,copy)NSString<Optional>*order;
@property(nonatomic,copy)NSString<Optional>*priority;
@property(nonatomic,copy)NSString<Optional>*imodify;
@property(nonatomic,copy)NSString<Optional>*boardid;
@property(nonatomic,copy)NSString<Optional>*url_3w;
@property(nonatomic,copy)NSString<Optional>*temp;
@property(nonatomic,copy)NSString<Optional>*votecount;
@property(nonatomic,copy)NSString<Optional>*alias;
@property(nonatomic,copy)NSString<Optional>*cid;
@property(nonatomic,copy)NSString<Optional>*url;
@property(nonatomic,copy)NSString<Optional>*hasAD;
@property(nonatomic,copy)NSString<Optional>*source;
@property(nonatomic,copy)NSString<Optional>*subtitle;
@property(nonatomic,copy)NSString<Optional>*imgsrc;
@property(nonatomic,copy)NSString<Optional>*tname;
@property(nonatomic,copy)NSString<Optional>*ename;
@property(nonatomic,copy)NSString<Optional>*ptime;

@property(nonatomic,copy)NSMutableArray<CBAImgextraModel,Optional>*imgextra;

@end

@interface HKCBAModel : JSONModel

@property(nonatomic,strong)NSMutableArray<CBAT1Model>*T1348649475931;

@end






























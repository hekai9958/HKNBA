//
//  CBAWebModel.h
//  HKNBA
//
//  Created by qianfeng on 15/12/18.
//  Copyright © 2015年 贺凯. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol CbaSysModel <NSObject>
@end
@interface CbaSysModel : JSONModel
@property(nonatomic,copy)NSString<Optional>*myId;
@property(nonatomic,copy)NSString<Optional>*title;
@property(nonatomic,copy)NSString<Optional>*source;
@property(nonatomic,copy)NSString<Optional>*imgsrc;
@property(nonatomic,copy)NSString<Optional>*type;
@property(nonatomic,copy)NSString<Optional>*ptime;
@property(nonatomic,copy)NSString<Optional>*href;
@end

@protocol CbaSearchModel <NSObject>
@end
@interface CbaSearchModel : JSONModel
@property(nonatomic,copy)NSString<Optional>*word;
@end

@protocol CbaNewsModel <NSObject>
@end
@interface CbaNewsModel : JSONModel
@property(nonatomic,copy)NSString<Optional>*hasCover;
@property(nonatomic,copy)NSString<Optional>*subnum;
@property(nonatomic,copy)NSString<Optional>*alias;
@property(nonatomic,copy)NSString<Optional>*tname;
@property(nonatomic,copy)NSString<Optional>*ename;
@property(nonatomic,copy)NSString<Optional>*tid;
@property(nonatomic,copy)NSString<Optional>*cid;
@end

@protocol CbaImgModel <NSObject>
@end
@interface CbaImgModel : JSONModel
@property(nonatomic,copy)NSString<Optional>*ref;
@property(nonatomic,copy)NSString<Optional>*pixel;
@property(nonatomic,copy)NSString<Optional>*alt;
@property(nonatomic,copy)NSString<Optional>*src;
@property(nonatomic,copy)NSString<Optional>*photosetID;
@end


@interface CBAWebModel: JSONModel

@property(nonatomic,copy)NSString<Optional>*body;
//@property(nonatomic,copy)NSString<Optional>*users;
@property(nonatomic,copy)NSString<Optional>*replyCount;
//@property(nonatomic,copy)NSString<Optional>*ydbaike;
//@property(nonatomic,copy)NSString<Optional>*link;
//@property(nonatomic,copy)NSString<Optional>*votes;

@property(nonatomic,copy)NSMutableArray<Optional,CbaImgModel>*img;
//@property(nonatomic,copy)NSString<Optional>*digest;

@property(nonatomic,copy)NSMutableArray<Optional,CbaNewsModel>*topiclist_news;
@property(nonatomic,copy)NSString<Optional>*dkeys;
//@property(nonatomic,copy)NSString<Optional>*topiclist;
@property(nonatomic,copy)NSString<Optional>*docid;
@property(nonatomic,copy)NSString<Optional>*picnews;
@property(nonatomic,copy)NSString<Optional>*title;
//@property(nonatomic,copy)NSString<Optional>*tid;
@property(nonatomic,copy)NSMutableArray<Optional,CbaSearchModel>*keyword_search;

@property(nonatomic,copy)NSString<Optional>*temp;
@property(nonatomic,copy)NSString<Optional>*threadVote;
@property(nonatomic,copy)NSString<Optional>*threadAgainst;
//@property(nonatomic,copy)NSString<Optional>*boboList;
@property(nonatomic,copy)NSString<Optional>*replyBoard;
@property(nonatomic,copy)NSString<Optional>*source;
@property(nonatomic,copy)NSString<Optional>*hasNext;
@property(nonatomic,copy)NSString<Optional>*voicecomment;
@property(nonatomic,copy)NSMutableArray<Optional,CbaSysModel>*relative_sys;

//@property(nonatomic,copy)NSString<Optional>*apps;
@property(nonatomic,copy)NSString<Optional>*ptime;


@end

//
//  WeiboViewControlle.h
//  wq
//
//  Created by weqia on 13-8-28.
//  Copyright (c) 2013年 Weqia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageLoadFootView.h"
#import "WeiboData.h"
#import "HBCoreLabel.h"

#define WeiboUpdateNotification  @"WeiboUpdateNotification"
@interface WeiboViewControlle : UIViewController<PageLoadFootViewDelegate,UIActionSheetDelegate,HBCoreLabelDelegate,UITableViewDataSource,UITableViewDelegate>
{

    
    NSMutableArray * _artArr;
    
    NSMutableDictionary * _artDic;
    
    void(^_block)(NSString*string);
    
    WeiboData * _deleteWeibo;
    
    NSIndexPath *_deletePath;
    
    BOOL  animationEnd;
}
@property(nonatomic,strong)NSArray*datas;
@property(nonatomic,strong)WeiboData * weiboData;
@property(nonatomic,strong)WeiboReplyData * replyData;
@property(nonatomic,strong)WeiboData * deleteWeibo;
@property(nonatomic,strong) UIView * superView;
@property(nonatomic,weak) IBOutlet UITableView * tableView;

@end

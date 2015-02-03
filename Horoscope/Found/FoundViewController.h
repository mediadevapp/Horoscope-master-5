//
//  FoundViewController.h
//  Horoscope
//
//  Created by Satellite on 14/12/17.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import "BaseViewController.h"
#import "FriendsCell.h"
@interface FoundViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,FriendsDelegate>
@property (nonatomic, assign)BOOL isFriends;
@end

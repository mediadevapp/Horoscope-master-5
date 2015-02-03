//
//  FansViewController.h
//  Horoscope
//
//  Created by Satellite on 14/12/23.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import "BaseViewController.h"

@interface FansViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,assign)BOOL isFans;
@end

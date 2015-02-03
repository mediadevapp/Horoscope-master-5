//
//  XWViewController.h
//  Horoscope
//
//  Created by Satellite on 14/12/4.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import "BaseViewController.h"
#import "XingWenTableViewCell.h"
#import "EGOImageView.h"
#import "XWCell.h"

@interface XWViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UMSocialDataDelegate,UMSocialUIDelegate,xingwenCellDelegate,XwCellDelegate>


@property (nonatomic,strong)NSArray * allArray;

@property (nonatomic,strong)UITableView * tableView;

@end

//
//  MineViewController.h
//  Horoscope
//
//  Created by Satellite on 14/12/11.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import "BaseViewController.h"

@interface MineViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,assign)BOOL isRootView;
@property (nonatomic,copy) NSString * userid;
@property (nonatomic,assign)BOOL isUpLoadHeadImg;
@end

//
//  PhotoViewController.h
//  Horoscope
//
//  Created by Satellite on 14/12/16.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import "BaseViewController.h"
#import "EGOImageView.h"
@interface PhotoViewController : BaseViewController<UIScrollViewDelegate>
@property(nonatomic,strong)NSMutableArray *photoArray;
@property(nonatomic,assign)int num;
@end

//
//  FriendsCell.h
//  Horoscope
//
//  Created by Satellite on 14/12/17.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@protocol FriendsDelegate ;


@interface FriendsCell : UITableViewCell
@property (nonatomic,strong)EGOImageView * headimgView;
@property (nonatomic,strong)UILabel * nameLb;
@property (nonatomic,strong)UIImageView * starImgView;
@property (nonatomic,strong)UILabel * starLb;
@property (nonatomic,strong)UILabel * ageLb;
@property (nonatomic,strong)UILabel * signatureLb;
@property (nonatomic,strong)UILabel * timeLabel;
@property (nonatomic,strong)UIImageView * sexImg;
@property (nonatomic,strong)UIButton * gzBtn;
@property (nonatomic,assign)id<FriendsDelegate>delegate;
@end

@protocol FriendsDelegate <NSObject>

-(void)didClickFollowWithCell:(FriendsCell *)cell;

@end
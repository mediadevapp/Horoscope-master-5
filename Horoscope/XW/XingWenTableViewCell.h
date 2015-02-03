//
//  XingWenTableViewCell.h
//  Horoscope
//
//  Created by SAT on 14/12/18.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol xingwenCellDelegate;
@interface XingWenTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *zan;
@property (weak, nonatomic) IBOutlet UIButton *pinglun;
@property (weak, nonatomic) IBOutlet UIButton *share;

@property (weak, nonatomic) IBOutlet UIImageView *facePic;

@property (weak, nonatomic) IBOutlet UIButton *titleName;

@property (weak, nonatomic) IBOutlet UILabel *newsTime;

@property (weak, nonatomic) IBOutlet UITextView *newsText;
@property (weak, nonatomic) IBOutlet UIImageView *newsPic;
@property (nonatomic,assign)id<xingwenCellDelegate>delegate;


@end
@protocol xingwenCellDelegate <NSObject>

-(void)didClickShareWithCell:(XingWenTableViewCell *)cell;

@end


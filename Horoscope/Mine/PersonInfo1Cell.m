//
//  CircleCell.m
//  Horoscope
//
//  Created by Satellite on 14/12/16.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import "PersonInfo1Cell.h"

@implementation PersonInfo1Cell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
        lb.backgroundColor = [UIColor clearColor];
        lb.textColor = [UIColor blackColor];
        lb.font = [UIFont boldSystemFontOfSize:16];
        lb.text = @"我的星友圈";
        [self addSubview:lb];
        
        
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 10, 60, 60)];
        self.imgView.image = KUIImage(@"placeholder.jpg");
        [self addSubview:self.imgView];
        
        
        self.xxLabel = [[UILabel alloc]initWithFrame:CGRectMake(170, 10, KScreenWidth-200, 60)];
        self.xxLabel.numberOfLines = 2;
        self.xxLabel.font = [UIFont boldSystemFontOfSize:15];
        self.xxLabel.textColor = [UIColor grayColor];
        self.xxLabel.text = @"圣诞节飞拉萨的就是浪费阿斯利康大姐夫临时卡大风阿里山的风景沙拉；快递费拉上看到阿拉山口大风";
        [self addSubview:self.xxLabel];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

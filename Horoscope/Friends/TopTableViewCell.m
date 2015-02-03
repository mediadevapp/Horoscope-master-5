//
//  TopTableViewCell.m
//  Horoscope
//
//  Created by Satellite on 14/12/17.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import "TopTableViewCell.h"

@implementation TopTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headimgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 60, 60)];
        [self addSubview:self.headimgView];
        
        
        self.nameLb = [[UILabel alloc]initWithFrame:CGRectMake(sx(self.headimgView)+10, 0, 200, 90)];
        self.nameLb.textColor = [UIColor blackColor];
        self.nameLb.font = [UIFont boldSystemFontOfSize:17];
        [self addSubview:self.nameLb];
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

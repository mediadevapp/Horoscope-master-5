//
//  PersonInfoCell.m
//  Horoscope
//
//  Created by Satellite on 14/12/16.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import "PersonInfoCell.h"

@implementation PersonInfoCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 40)];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        self.titleLabel.textColor = [UIColor grayColor];
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview: self.titleLabel];
        
        
        self.ctLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 0, KScreenWidth-180, 40)];
        self.ctLabel.font = [UIFont systemFontOfSize:14];
        self.ctLabel.textAlignment   = NSTextAlignmentLeft;
        self.ctLabel.textColor = [UIColor blackColor];
        [self addSubview:self.ctLabel];
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

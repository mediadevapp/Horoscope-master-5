//
//  FriendsCell.m
//  Horoscope
//
//  Created by Satellite on 14/12/17.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import "FriendsCell.h"

@implementation FriendsCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headimgView = [[EGOImageView alloc]initWithFrame:CGRectMake(20, 15, 60, 60)];
        [self addSubview:self.headimgView];
        
        
        self.nameLb = [[UILabel alloc]initWithFrame:CGRectMake(sx(self.headimgView)+10, 15, KScreenWidth-70-sx(self.headimgView), 20)];
        self.nameLb.textColor = [UIColor blackColor];
        self.nameLb.font = [UIFont boldSystemFontOfSize:17];
        [self addSubview:self.nameLb];
        
        
        
        self.sexImg = [[UIImageView alloc]initWithFrame:CGRectMake(sx(self.headimgView)+10, sy(self.nameLb)+7, 35, 15)];
//        self.sexImg.backgroundColor = [UIColor redColor];

        [self addSubview:self.sexImg];
        
        self.ageLb = [[UILabel alloc]initWithFrame:CGRectMake(sx(self.headimgView)+10, sy(self.nameLb)+7, 35, 13)];
        self.ageLb.font = [UIFont boldSystemFontOfSize:10];
        self.ageLb.backgroundColor = [UIColor clearColor];
        self.ageLb.textColor = [UIColor whiteColor];
        self.ageLb.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.ageLb];
        
        
        self.starImgView = [[UIImageView alloc]initWithFrame:CGRectMake(sx(self.sexImg)+10, sy(self.nameLb)+3, 20, 20)];
        [self addSubview:self.starImgView];

        self.starLb =[[UILabel alloc]initWithFrame:CGRectMake(sx(self.starImgView)+10, sy(self.nameLb)+3, 150, 20)];
        self.starLb.textColor = [UIColor grayColor];
        self.starLb.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.starLb];
        
        self.signatureLb =[[UILabel alloc]initWithFrame:CGRectMake(sx(self.headimgView)+10, sy(self.starLb), KScreenWidth-65-sx(self.headimgView), 20)];
        self.signatureLb.textColor = [UIColor grayColor];
        self.signatureLb.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.signatureLb];

        self.timeLabel =[[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth-70, 15, 70, 20)];
        self.timeLabel.textColor = [UIColor grayColor];
        self.timeLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.timeLabel];
        
        self.gzBtn = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth-65, sy(self.nameLb)+3, 40, 20)];
//        self.gzBtn.backgroundColor = kColorWithRGB(220, 220, 220, 1);
        [self.gzBtn setTitle:@"关注" forState:UIControlStateNormal];
        self.gzBtn.layer.masksToBounds = YES;
        self.gzBtn.layer.cornerRadius = 6.0;
        self.gzBtn.layer.borderWidth = 0.5;
        self.gzBtn.tag = self.tag;
         self.gzBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.gzBtn addTarget:self action:@selector(gzgzgz:) forControlEvents:UIControlEventTouchUpInside];
        self.gzBtn.layer.borderColor = [[UIColor grayColor] CGColor];
        [self.gzBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self addSubview:self.gzBtn];
        
        }
    return self;
}

-(void)gzgzgz:(UIButton *)sender
{
        [self.gzBtn setTitle:@"已关注" forState:UIControlStateNormal];
        if ([self.delegate respondsToSelector:@selector(didClickFollowWithCell:)]) {
            [self.delegate didClickFollowWithCell:self];
        }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

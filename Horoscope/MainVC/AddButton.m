//
//  AddButton.m
//  Horoscope
//
//  Created by Satellite on 14/12/4.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import "AddButton.h"

@implementation AddButton
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
     
        self.backgroundColor = [UIColor clearColor];
        [self setBackgroundImage:KUIImage(@"弹窗") forState:UIControlStateNormal];
        
        self.constellationImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 25, 25)];
        [self addSubview:self.constellationImg];
        
        self.constellationLab = [[UILabel alloc]initWithFrame:CGRectMake(55, 5, 120, 25)];
        self.constellationLab.backgroundColor =[UIColor clearColor];
        self.constellationLab.font = [UIFont boldSystemFontOfSize:17];
        self.constellationLab.textColor = [UIColor whiteColor];
        [self addSubview:self.constellationLab];
        
        self.nameLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, 150, 20)];
        self.nameLab.backgroundColor = [UIColor clearColor];
        self.nameLab.font = [UIFont systemFontOfSize:14];
        self.nameLab.textColor = [UIColor whiteColor];
        [self addSubview:self.nameLab];
        
        self.lineLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, 240, 20)];
        self.lineLab.backgroundColor = [UIColor clearColor];
        self.lineLab.font = [UIFont systemFontOfSize:13];
        self.lineLab.textColor = [UIColor grayColor];
        [self addSubview:self.lineLab];

        
        UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-60, 15, 42, 42)];
        imgv.image = KUIImage(@"弹窗正常状态");
        [self addSubview:imgv];
        
        UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width-60, 15, 42, 42)];
        lb.backgroundColor =[UIColor clearColor];
        lb.textColor = [UIColor whiteColor];
        lb.font = [UIFont boldSystemFontOfSize:20];
        lb.text = @"MY";
        lb.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lb];
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

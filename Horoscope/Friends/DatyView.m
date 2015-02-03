//
//  DatyView.m
//  Horoscope
//
//  Created by Satellite on 14/12/27.
//
//

#import "DatyView.h"

@implementation DatyView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.leftLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 1, frame.size.width-80, 59)];
        self.leftLb.textColor = [UIColor blackColor];
        self.leftLb.font = [UIFont boldSystemFontOfSize:16];
        [self addSubview:self.leftLb];
        
        
        self.rightImgView = [[EGOImageView alloc]initWithFrame:CGRectMake(frame.size.width-60, 5, 50, 50)];
        self.rightImgView.backgroundColor = [UIColor greenColor];
        [self addSubview:self.rightImgView];

        self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 0.5)];
        self.lineView.backgroundColor = [UIColor grayColor];
        [self addSubview:self.lineView];
        
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

//
//  CircleBtn.m
//  Horoscope
//
//  Created by Satellite on 15/1/5.
//
//

#import "CircleBtn.h"

@implementation CircleBtn
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.countLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, frame.size.width-20, frame.size.height)];
        self.countLabel.font = [UIFont boldSystemFontOfSize:12];
        self.countLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.countLabel];
        
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

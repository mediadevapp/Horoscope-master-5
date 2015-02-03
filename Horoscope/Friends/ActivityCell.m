//
//  ActivityCell.m
//  Horoscope
//
//  Created by Satellite on 14/12/27.
//
//

#import "ActivityCell.h"

@implementation ActivityCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kColorWithRGB(220, 220, 220, 1);
        
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 20)];
        self.timeLabel.center = CGPointMake(KScreenWidth/2, 20);
        self.timeLabel.textColor = [UIColor whiteColor];
        self.timeLabel.font = [UIFont systemFontOfSize:13];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        self.timeLabel.backgroundColor = kColorWithRGB(1, 1, 1, .7);
        [self.contentView addSubview:self.timeLabel];
        
        
        
        self.bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 40, KScreenWidth-40, self.contentView.frame.size.height-40)];
        self.bgImgView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.bgImgView];
        
        
        self.topImageView = [[EGOImageButton alloc]initWithFrame:CGRectMake(10, 10, KScreenWidth-40, width(self.bgImgView)/4*3)];
        self.topImageView.placeholderImage = KUIImage(@"123.jpg");
        self.topImageView.backgroundColor = kColorWithRGB(225.0/225.0f, 225.0/225.0f, 225.0/225.0f, 0.7);
        [self.bgImgView addSubview:self.topImageView];
        
        self.titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, height(self.topImageView)-30, width(self.topImageView), 30)];
        self.titleLb.backgroundColor = kColorWithRGB(1, 1, 1, .7);
        self.titleLb.textColor =[UIColor whiteColor];
        self.titleLb.font = [UIFont boldSystemFontOfSize:14];
        [self.topImageView addSubview:self.titleLb];
        
        self.datyView1 = [[DatyView alloc]initWithFrame:CGRectMake(20, 10+width(self.bgImgView)/4*3, width(self.topImageView), 60)];
        self.datyView1.lineView.hidden = YES;
        self.datyView2 = [[DatyView alloc]initWithFrame:CGRectMake(20, 10+width(self.bgImgView)/4*3+60, width(self.topImageView), 60)];
        self.datyView3 = [[DatyView alloc]initWithFrame:CGRectMake(20, 10+width(self.bgImgView)/4*3+120, width(self.topImageView), 60)];
        self.datyView4 = [[DatyView alloc]initWithFrame:CGRectMake(20, 10+width(self.bgImgView)/4*3+180, width(self.topImageView), 60)];
        self.datyView1.rightImgView.placeholderImage = KUIImage(@"placeholder.jpg");
        self.datyView2.rightImgView.placeholderImage = KUIImage(@"placeholder.jpg");
        self.datyView3.rightImgView.placeholderImage = KUIImage(@"placeholder.jpg");
        self.datyView4.rightImgView.placeholderImage = KUIImage(@"placeholder.jpg");

        [self.bgImgView addSubview:self.datyView1];
        [self.bgImgView addSubview:self.datyView2];
        [self.bgImgView addSubview:self.datyView3];
        [self.bgImgView addSubview:self.datyView4];
        
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

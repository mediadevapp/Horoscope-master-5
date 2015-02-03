//
//  XWCell.m
//  Horoscope
//
//  Created by Satellite on 15/1/26.
//
//

#import "XWCell.h"

@implementation XWCell

//- (void)awakeFromNib {
//    // Initialization code
//}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.facePic =[[EGOImageButton alloc]initWithFrame:CGRectMake(14, 6, 40, 40)];
        [self addSubview:self.facePic];
        
        self.titleName = [[UILabel alloc]initWithFrame:CGRectMake(70, 6, 200, 20)];
        self.titleName.textColor  = [UIColor blueColor];
        self.titleName.backgroundColor = [UIColor clearColor];
        self.titleName.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.titleName];
        
        self.newsText = [[UITextView alloc]initWithFrame:CGRectMake(14, 60, KScreenWidth-28, 150)];
        self.newsText.scrollEnabled = NO;
        self.newsText.backgroundColor = [UIColor clearColor];
        self.newsText.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.newsText];
        
        self.newsPic = [[EGOImageView alloc]initWithFrame:CGRectMake(14, 220, KScreenWidth-28, 150)];
        [self addSubview:self.newsPic];
        
        self.share = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth-100, sy(self.newsText)+10, 84, 28)];
        [self.share setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [self.share setBackgroundImage:KUIImage(@"share") forState:UIControlStateNormal];
        [self.share addTarget:self action:@selector(shareToThirdPage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.share];
        
    }
    return self;
}
-(void)shareToThirdPage:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(didClickShareWithCell:)]) {
        [self.delegate didClickShareWithCell:self];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

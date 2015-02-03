//
//  CircleCell.m
//  Horoscope
//
//  Created by Satellite on 15/1/5.
//
//

#import "CircleCell.h"

@implementation CircleCell
{
    UIView *customCommentView;
    UIView * zanView;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headImageView = [[EGOImageButton alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
        [self.headImageView addTarget:self action:@selector(enterPersonInfoPage:) forControlEvents:UIControlEventTouchUpInside];
        self.headImageView.placeholderImage = KUIImage(@"placeholder.jpg");
        self.headImageView.backgroundColor = [UIColor grayColor];
        [self addSubview:self.headImageView];
        
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(sx(self.headImageView)+10, 10, KScreenWidth-sx(self.headImageView), 20)];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.font = [UIFont boldSystemFontOfSize:13];
        self.nameLabel.textColor = [UIColor blueColor];
        [self addSubview:self.nameLabel];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(sx(self.headImageView)+10, sy(self.nameLabel)+5, KScreenWidth-sx(self.headImageView)-20, 20)];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font  = [UIFont systemFontOfSize:14];
        [self addSubview:self.titleLabel];
        
        self.cImageView = [[EGOImageView alloc]initWithFrame:CGRectMake(sx(self.headImageView)+10, sy(self.titleLabel), KScreenWidth-sx(self.headImageView)-40, 200)];
        [self addSubview:self.cImageView];
        
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(sx(self.headImageView)+10, sy(self.cImageView)+5,150, 20)];
        self.timeLabel.numberOfLines = 0;
        self.timeLabel.textColor = [UIColor grayColor];
        self.timeLabel.backgroundColor = [UIColor clearColor];
        self.timeLabel.font  = [UIFont systemFontOfSize:12];
        [self addSubview:self.timeLabel];

        self.menuBtn = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth-60, sy(self.cImageView)+5, 50, 30)];
        [self.menuBtn addTarget:self action:@selector(showZanBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.menuBtn setBackgroundImage:KUIImage(@"More－Normal") forState:UIControlStateNormal];
//        [self.menuBtn setBackgroundImage:KUIImage(@"") forState:UIControlStateHighlighted];
        [self addSubview:self.menuBtn];
        
        self.zanBtn = [[CircleBtn alloc]initWithFrame:CGRectMake(sx(self.menuBtn)-140-50, height(self.menuBtn), 70, 30)];
        self.commBtn =[[CircleBtn alloc]initWithFrame:CGRectMake(sx(self.zanBtn), height(self.menuBtn), 70, 30)];
        
        [self.zanBtn setBackgroundImage:KUIImage(@"zan-Normal") forState:UIControlStateNormal];
        [self.commBtn setBackgroundImage:KUIImage(@"pinglun-Normal") forState:UIControlStateNormal];
        self.zanBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        self.commBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        
        self.zanBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        self.commBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        
        
        [self.zanBtn addTarget:self action:@selector(didClickZan:) forControlEvents:UIControlEventTouchUpInside];
        [self.commBtn addTarget:self action:@selector(didClikcComm:) forControlEvents:UIControlEventTouchUpInside];
        self.zanBtn.hidden = YES;
        self.commBtn.hidden = YES;
        
        [self addSubview:self.zanBtn];
        [self addSubview:self.commBtn];
        
    }
    
    return self;
}

-(void)buildZanViewWithdic:(NSDictionary *)dic
{
    UILabel *lb;
    
    if (!self.zanView) {
        self.zanView = [[UIImageView alloc]initWithFrame:CGRectMake(sx(self.headImageView)+10, sy(self.timeLabel)+10, KScreenWidth-sx(self.headImageView)-40, 30)];
        self.zanView.image = KUIImage(@"pingluntiao-shang");
        
        UIImageView *timg = [[UIImageView alloc]initWithFrame:CGRectMake(3, 7, 20, 20)];
        timg.image = KUIImage(@"pengyouquan-xingqing-zan");
        [self.zanView addSubview:timg];
        
        lb = [[UILabel alloc]initWithFrame:CGRectMake(sx(timg)+5, 7, width(self.zanView)-sx(timg)-5, 20)];
        lb.font = [UIFont systemFontOfSize:12];
        lb.backgroundColor = [UIColor clearColor];
        lb.textColor = [UIColor blueColor];
        [self.zanView addSubview:lb];
        [self addSubview:self.zanView];
        
    }
    lb.text = @"1231231231";
}

-(void)buildCommentViewWithDic:(NSArray *)arr
{
    NSLog(@"---------%lu",(unsigned long)arr.count);
    NSLog(@"self.tag==%ld",(long)self.tag);
    if (customCommentView) {
        [customCommentView removeFromSuperview];
    }
    
    if (arr.count<1) {
        return;
    }
    
    customCommentView = [[UIView alloc]initWithFrame:CGRectMake(sx(self.headImageView)+10, sy(self.timeLabel), KScreenWidth-sx(self.headImageView)-40, 20*arr.count)];
    [self addSubview:customCommentView];
    
    for (int i = 0; i<arr.count; i++) {
//        NSDictionary *dic  = arr[i];
        float zanHeight = 0.0;
        if (self.zanView) {
            zanHeight = 40.0;
        }else{
            zanHeight = 10.0;
        }
        
        [self buildCommentViewWithFrame:CGRectMake(0,20*i+zanHeight, KScreenWidth-sx(self.headImageView)-40, 20) text:arr[i]view:customCommentView];
    }
}

-(void)buildCommentViewWithFrame:(CGRect)frame text:(NSString *)text view:(UIView *)view
{
    UIImageView * commView= [[UIImageView alloc]initWithFrame:frame];
    commView.image = KUIImage(@"pingluntiao-xia");
    commView.backgroundColor = [ UIColor clearColor];
    UILabel *commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, commView.frame.size.width-30, 20)];
    commentLabel.font = [UIFont systemFontOfSize:12];
    commentLabel.backgroundColor = [UIColor clearColor];
    commentLabel.text = text;
    NSLog(@"%@,%@",commentLabel.text,commentLabel);
    commentLabel.textColor = [UIColor blackColor];
    [commView addSubview:commentLabel];
    [view addSubview:commView];
}


#pragma mark----点击头像
-(void)enterPersonInfoPage:(UIButton *)button
{
    NSLog(@"点击头像");
}

-(void)showZanBtn:(UIButton *)sender
{
    if (self.zanBtn.hidden) {
        self.zanBtn.hidden = NO;
        self.commBtn.hidden = NO;
    }else{
        self.zanBtn.hidden = YES;
        self.commBtn.hidden = YES;

    }
}

-(void)didClickZan:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(didClickZanWithCell:)]) {
        [self.delegate didClickZanWithCell:self];
    }
}
-(void)didClikcComm:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(didClickCommWithCell:)]) {
        [self.delegate didClickCommWithCell:self];
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

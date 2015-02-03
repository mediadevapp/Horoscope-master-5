//
//  TastCell.m
//  Horoscope
//
//  Created by Satellite on 14/12/27.
//
//

#import "TastCell.h"

@implementation TastCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, KScreenWidth-80, 60)];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [self addSubview:self.titleLabel];
        
        
        self.imgView = [[EGOImageView alloc]initWithFrame:CGRectMake(KScreenWidth-70, 5, 50, 50)];
        self.imgView.placeholderImage = KUIImage(@"placeholder.jpg");
        [self addSubview:self.imgView];

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

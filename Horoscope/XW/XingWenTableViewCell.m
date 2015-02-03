//
//  XingWenTableViewCell.m
//  Horoscope
//
//  Created by SAT on 14/12/18.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import "XingWenTableViewCell.h"

@implementation XingWenTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)zanAction:(id)sender {
}
- (IBAction)pinglunAction:(id)sender {
}

- (IBAction)shareAction:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(didClickShareWithCell:)]) {
        [self.delegate didClickShareWithCell:self];
    }
}


@end

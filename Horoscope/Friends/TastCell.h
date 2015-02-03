//
//  TastCell.h
//  Horoscope
//
//  Created by Satellite on 14/12/27.
//
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
@interface TastCell : UITableViewCell
@property (nonatomic,strong)EGOImageView * imgView;
@property (nonatomic,strong)UILabel * titleLabel;
@end

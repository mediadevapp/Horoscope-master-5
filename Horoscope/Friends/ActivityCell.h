//
//  ActivityCell.h
//  Horoscope
//
//  Created by Satellite on 14/12/27.
//
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "EGOImageButton.h"
#import "DatyView.h"
@interface ActivityCell : UITableViewCell
@property (nonatomic,strong)UIImageView *bgImgView;
@property (nonatomic,strong)EGOImageButton *topImageView;
@property (nonatomic,strong)UILabel * titleLb;
@property (nonatomic,strong)DatyView * datyView1;
@property (nonatomic,strong)DatyView * datyView2;
@property (nonatomic,strong)DatyView * datyView3;
@property (nonatomic,strong)DatyView * datyView4;
@property (nonatomic,strong)UILabel * timeLabel;
@end

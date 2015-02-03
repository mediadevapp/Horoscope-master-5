//
//  DatyView.h
//  Horoscope
//
//  Created by Satellite on 14/12/27.
//
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
@interface DatyView : UIButton
@property (nonatomic,strong)UILabel * leftLb;
@property (nonatomic,strong)EGOImageView * rightImgView;
@property (nonatomic,strong)UIView *lineView;
@end

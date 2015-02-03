//
//  MainCollectionViewCell.h
//  Horoscope
//
//  Created by Satellite on 14/12/4.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
@interface MainCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)UIImageView * leftImageView;
@property (nonatomic,strong)EGOImageView * MainImageView;
@property (nonatomic,strong)UILabel     * numLabel;
@property (nonatomic,strong)UILabel     *nameLabel;
@end

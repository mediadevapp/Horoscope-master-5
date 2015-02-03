//
//  TopView.h
//  Horoscope
//
//  Created by Satellite on 14/12/8.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopButton.h"


@protocol TopViewDelegate;

@interface TopView : UICollectionReusableView
@property(nonatomic,strong)TopButton *cell1;
@property(nonatomic,strong)TopButton *cell2;
@property(nonatomic,strong)TopButton *cell3;
@property(nonatomic,strong)TopButton *cell4;
@property(nonatomic,strong)TopButton *cell5;
@property(nonatomic,strong)TopButton *cell6;
@property (nonatomic,assign)id<TopViewDelegate>delegate;
@property (nonatomic,assign)NSMutableArray *infoArray;
-(void)changeImgAndName:(NSMutableArray *)arr;

@end

@protocol TopViewDelegate <NSObject>

-(void)didClickButton:(NSInteger)n;
@end
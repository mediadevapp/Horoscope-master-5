//
//  MBButtonShowView.h
//  BOCMBCI
//
//  Created by SAT on 14/12/31.
//  Copyright (c) 2014年 China M-World Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBButtonShowView : UIButton
@property (nonatomic,strong)UIImage * imageViewForShow;
@property (nonatomic,strong)UITextView * textViewForShow;

@property (nonatomic,strong)UIScrollView * contentScrollView;
@property (nonatomic,strong)UIView * backgroudView;

@property (nonatomic,strong)UIViewController * selfVC;

- (id)initWithFrame:(CGRect)frame showImage:(UIImage *)imageView Title:(NSString *)title WithTarget:(UIViewController *)selfVC;

- (id)initWithFrame:(CGRect)frame showTextView:(UITextView *)textView Title:(NSString *)title WithTarget:(UIViewController *)selfVC;

@end

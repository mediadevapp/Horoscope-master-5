//
//  MenuViewController.h
//  Horoscope
//
//  Created by 01 on 14/11/25.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *starNews;
@property (weak, nonatomic) IBOutlet UIButton *starSay;
@property (weak, nonatomic) IBOutlet UIButton *superShow;
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UIView *newsView;
@property (weak, nonatomic) IBOutlet UIView *showView;
- (IBAction)didClickMine:(UIButton *)sender;

@end

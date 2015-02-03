//
//  SecondViewController.m
//  NewDemo
//
//  Created by Satellite on 14/11/26.
//  Copyright (c) 2014年 Satellite. All rights reserved.
//

#import "TodayViewController.h"
#import "UIViewController+JDSideMenu.h"
#import "JDSideMenu.h"
@interface TodayViewController ()

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildTopviewWithBackButton:YES title:@"今日运势"];
    
    UIScrollView *scr = [[ UIScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64)];
    scr.backgroundColor = [UIColor whiteColor];
    scr.contentSize = CGSizeMake(0, 188+64+139+400);
    [self.view addSubview:scr];
    
    UIImageView *imageView1 =[[ UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 188)];
    imageView1.image = [UIImage imageNamed:@"todayYs"];
    [scr addSubview:imageView1];
    
    UIImageView *imageView2 =[[ UIImageView alloc]initWithFrame:CGRectMake(0,188, self.view.bounds.size.width, 139)];
    imageView2.image = [UIImage imageNamed:@"todayYs2"];
    [scr addSubview:imageView2];
    
    
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(20, 188+139, self.view.bounds.size.width-40, 400)];
    textView.text = @"概述：\n       冲动、爱冒险、慷慨、天不怕地不怕，而且一旦下定决心，排除万难的要达到目的。大部分属于白羊座的人的脾气都很差，不过只是炮仗颈，绝对不会放在心上，很快便会没有事，而记仇的天蝎座便正好是白羊座的相反。白羊座是黄道第一宫，因此他最喜欢成为第一的强者星座，另外，火星掌管白羊座，他们必须燃起熊熊的烈火，否则人生黯然无光。白羊座就像小孩子一样，直率、热情、冲动，但也十分的自我为中心和孩子气。白羊座的男人都是典型的大男人主义者，一定要靠自己要开创自己的成功";
    textView.userInteractionEnabled = NO;
    textView.font = [UIFont systemFontOfSize:16];
    
    [scr addSubview:textView];
    
    // Do any additional setup after loading the view, typically from a nib.
//    [self.leftButton addTarget:self action:@selector(gotoMenu:) forControlEvents:UIControlEventTouchUpInside];
    
}
//- (void)gotoMenu:(UIGestureRecognizer * )ges
//{
//    if ([self.sideMenuController isMenuVisible]) {
//        [self.sideMenuController hideMenuAnimated:YES];
//    }else
//    {
//        [self.sideMenuController showMenuAnimated:YES];
//    }
//    
//    
//}
/*
 创建tabbar头条快捷方式
 */
-(void)buildTopviewWithBackButton:(BOOL)isHave title:(NSString *)title
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    imageView.backgroundColor = [UIColor colorWithRed:0/225.0f green:0/225.0f blue:0/225.0f alpha:1];
    imageView.image =[UIImage imageNamed:@""];
    imageView.userInteractionEnabled =  YES;
    [self.view addSubview:imageView];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(70, 20, self.view.bounds.size.width-140, 44)];
    label.text = title;
    label.font = [UIFont boldSystemFontOfSize:22];
    label.textAlignment =NSTextAlignmentCenter;
    label.backgroundColor= [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    [imageView addSubview:label];
    
    
    _leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 60, 44)];
    [_leftButton setImage:[UIImage imageNamed:@"emnu.png"] forState:UIControlStateNormal];
    [imageView addSubview:_leftButton];
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-60, 20, 60, 44)];
    
    [rightButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    if (isHave) {
        rightButton.hidden = NO;
    }else{
        rightButton.hidden = YES;
    }
    [imageView addSubview:rightButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

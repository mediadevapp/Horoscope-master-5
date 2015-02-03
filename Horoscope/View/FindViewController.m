//
//  FirstViewController.m
//  NewDemo
//
//  Created by Satellite on 14/11/26.
//  Copyright (c) 2014年 Satellite. All rights reserved.
//

#import "FindViewController.h"
//#import "JDSideMenu.h"
//#import "UIViewController+JDSideMenu.h"

@interface FindViewController ()
{
    UIScrollView * topScl;
}
@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildTopviewWithBackButton:YES title:@"发现" rightImage:@""];
    // Do any additional setup after loading the view, typically from a nib.
    [self buildScrollViewWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64) contentSize:CGSizeMake(0, 1006) Image:@"fs_nr.png"];
    
    [self.leftButton addTarget:self action:@selector(gotoMenu:) forControlEvents:UIControlEventTouchUpInside];
    
   
}
- (void)gotoMenu:(UIGestureRecognizer * )ges
{
    
    
    [self.menuController.topBar menuBtn];
//    if ([self.sideMenuController isMenuVisible]) {
//        [self.sideMenuController hideMenuAnimated:YES];
//    }else
//    {
//        [self.sideMenuController showMenuAnimated:YES];
//    }
    
    
}

///*
// 创建tabbar头条快捷方式
// */
//-(void)buildTopviewWithBackButton:(BOOL)isHave title:(NSString *)title
//{
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
//    imageView.backgroundColor = [UIColor colorWithRed:0/225.0f green:0/225.0f blue:0/225.0f alpha:1];
//    imageView.image =[UIImage imageNamed:@""];
//    imageView.userInteractionEnabled =  YES;
//    [self.view addSubview:imageView];
//    
//    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(70, 20, self.view.bounds.size.width-140, 44)];
//    label.text = title;
//    label.font = [UIFont boldSystemFontOfSize:22];
//    label.textAlignment =NSTextAlignmentCenter;
//    label.backgroundColor= [UIColor clearColor];
//    label.textColor = [UIColor whiteColor];
//    [imageView addSubview:label];
//    
//    
//    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 60, 44)];
//    [leftButton setImage:[UIImage imageNamed:@"emnu.png"] forState:UIControlStateNormal];
//    [imageView addSubview:leftButton];
//    
//    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-60, 20, 60, 44)];
//    
//    [rightButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//    if (isHave) {
//        rightButton.hidden = NO;
//    }else{
//        rightButton.hidden = YES;
//    }
//    [imageView addSubview:rightButton];
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

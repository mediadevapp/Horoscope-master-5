//
//  MainViewController.m
//  Horoscope
//
//  Created by 01 on 14/11/28.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import "MainViewController.h"
#import "JDSideMenu.h"
#import "UIViewController+JDSideMenu.h"

@interface MainViewController ()
{
    UIImageView * blackImageView;
    UIButton * ccButton;
}

@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //    [self buildTopviewWithBackButton:NO title:@"星座达人秀 - TOP"];
    [self buildTopviewWithBackButton:NO title:@"星座达人秀 - TOP" rightImage:@""];
    
    UIScrollView *contentScl = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height)];
    contentScl.contentSize = CGSizeMake(0,1120);

    [self.view addSubview:contentScl];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1054)];
    imageView.image = [UIImage imageNamed:@"星座主页面"];
    [contentScl addSubview:imageView];
    NSLog(@"%f---%f",self.view.bounds.size.width,self.view.bounds.size.height);
    
    /*
     imageView 点击事件
     */
    
    
    [self.leftButton addTarget:self action:@selector(gotoMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    imageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer  * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOutPage:)];
    [imageView addGestureRecognizer:tap];
    
    [self buildBlackView];
    
    [self.leftButton addTarget:self action:@selector(gotoMenu:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)gotoMenu:(UIGestureRecognizer * )ges
{
   [self.menuController showMenu:self.menuController.topBar];
    
   
}


-(NSString*)titleForChildControllerMDMenuViewController:(MDMenuViewController *)menuController
{
    return @"星座达人";
}
-(NSString*)iconForChildControllerMDMenuViewController:(MDMenuViewController *)menuController
{
    return @"darenxiu.png";
}

-(void)buildBlackView
{
    blackImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height)];
    blackImageView.image = [UIImage imageNamed:@"blackView"];
    blackImageView.hidden = YES;
    blackImageView.userInteractionEnabled = YES;
    [blackImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didHiddenBlView:)]];
    [self.view addSubview:blackImageView];
    
    ccButton = [[UIButton alloc]initWithFrame:CGRectMake(-307, 400, 307, 72)];
    
    
    
    //    ccButton.backgroundColor = [UIColor clearColor];
    [ccButton setImage:[UIImage imageNamed:@"btimg"] forState:UIControlStateNormal];
    [ccButton addTarget:self action:@selector(didClickTap:) forControlEvents:UIControlEventTouchUpInside];
    ccButton.hidden = YES;
    [blackImageView addSubview:ccButton];
}

//点击显示遮罩层 隐藏主页面
-(void)tapOutPage:(UIGestureRecognizer*)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        ccButton.frame =CGRectMake(0, 400, 307, 72);
        
    } completion:^(BOOL finished) {
    }];

    
    blackImageView.hidden = NO;
    ccButton.hidden = NO;
}

//点击显示菜单栏

-(void)didClickTap:(UIButton *)sender
{
    
}

//点击隐藏遮罩层 显示主页面
-(void)didHiddenBlView:(UIGestureRecognizer*)sender
{
    
    [UIView animateWithDuration:0.5 animations:^{
        ccButton.frame =CGRectMake(-307, 400, 307, 72);
        
        
    } completion:^(BOOL finished) {
    }];
    blackImageView.hidden = YES;
    ccButton.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  FirstViewController.m
//  Demo4
//
//  Created by Satellite on 14/11/27.
//  Copyright (c) 2014年 Satellite. All rights reserved.
//

#import "StarDicController.h"

@interface StarDicController ()
{
    UIImageView *blueImageView;
    UIScrollView *scrollView;
}
@end

@implementation StarDicController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self buildTopviewWithBackButton:YES title:@"星座宝典" rightImage:@""];
    self.view.backgroundColor = [UIColor whiteColor];
    scrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 110, self.view.bounds.size.width, self.view.bounds.size.height-110)];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width*3, 0);
    scrollView.pagingEnabled = YES;
    scrollView.userInteractionEnabled = NO;
    [self.view addSubview:scrollView];
    
    
    NSArray *arr= [ NSArray arrayWithObjects:@"1",@"2",@"3", nil];
    
    NSArray * titleArr = [NSArray arrayWithObjects:@"传说",@"特点",@"爱情", nil];
    
    blueImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 108, self.view.bounds.size.width/3, 2)];
    blueImageView.image = [UIImage imageNamed:@"蓝色进度条(＃1cb4f6)"];
    [self.view addSubview:blueImageView];
    
    for (int i = 0;  i <3; i++) {
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/3*i, 64, self.view.bounds.size.width/3, 44)];
        
        [button setBackgroundImage:[UIImage imageNamed:@"灰色底框"] forState:UIControlStateNormal];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(changeScroll:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100+i;
        [self.view addSubview:button];
        
        if (button.tag ==100) {
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        }
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*i, 0, self.view.bounds.size.width, self.view.bounds.size.height-64-44)];
        imageView.image = [UIImage imageNamed:arr[i]];
        [scrollView addSubview:imageView];
    }
    
    
//    
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

-(void)changeScroll:(UIButton *)sender
{
    if (sender.tag ==100) {
        UIButton *button1 = (UIButton *)[self.view viewWithTag:100];
        [button1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        UIButton *button2 = (UIButton *)[self.view viewWithTag:101];
        [button2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        UIButton *button3 = (UIButton *)[self.view viewWithTag:102];
        [button3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.5 animations:^{
            blueImageView.frame = CGRectMake(0, 108, self.view.bounds.size.width/3, 2);
            scrollView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
        }];
        
        
    }else if (sender.tag ==101)
    {
        UIButton *button1 = (UIButton *)[self.view viewWithTag:100];
        [button1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        UIButton *button2 = (UIButton *)[self.view viewWithTag:101];
        [button2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        UIButton *button3 = (UIButton *)[self.view viewWithTag:102];
        [button3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.5 animations:^{
        blueImageView.frame = CGRectMake(self.view.bounds.size.width/3, 108, self.view.bounds.size.width/3, 2);
        scrollView.contentOffset = CGPointMake(self.view.bounds.size.width, 0);
    } completion:^(BOOL finished) {
    }];


    }
    else if (sender.tag==102)
    {
        UIButton *button1 = (UIButton *)[self.view viewWithTag:100];
        [button1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        UIButton *button2 = (UIButton *)[self.view viewWithTag:101];
        [button2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        UIButton *button3 = (UIButton *)[self.view viewWithTag:102];
        [button3 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.5 animations:^{
        blueImageView.frame = CGRectMake(self.view.bounds.size.width/3*2, 108, self.view.bounds.size.width/3, 2);
        scrollView.contentOffset = CGPointMake(self.view.bounds.size.width*2, 0);
        } completion:^(BOOL finished) {
        }];


    }
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

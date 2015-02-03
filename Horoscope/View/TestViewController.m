//
//  FirstViewController.m
//  NewDemo
//
//  Created by Satellite on 14/11/26.
//  Copyright (c) 2014年 Satellite. All rights reserved.
//

#import "TestViewController.h"
#import "JDSideMenu.h"
#import "UIViewController+JDSideMenu.h"

@interface TestViewController ()
{
    UIScrollView * topScl;
}
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildTopviewWithBackButton:YES title:@"测试" rightImage:@""];
    

    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"----%@",self.view);
    UIScrollView *scrol = [[UIScrollView alloc]initWithFrame:CGRectMake(0, startX, KScreenWidth, KScreenHeight-startX)];
    scrol.contentSize  = CGSizeMake(0, 811+165);
    scrol.showsHorizontalScrollIndicator = NO;
    scrol.showsVerticalScrollIndicator = NO;

    [self.view addSubview:scrol];
    
    topScl = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 165)];
    topScl.pagingEnabled = YES;
    topScl.delegate = self;
    topScl.contentOffset = CGPointMake(self.view.bounds.size.width, 0);
    topScl.contentSize = CGSizeMake(self.view.bounds.size.width*3, 0);
    topScl.showsHorizontalScrollIndicator = NO;
    topScl.showsVerticalScrollIndicator = NO;
    [scrol addSubview:topScl];
    
    NSArray *arr =[ NSArray arrayWithObjects:@"top1",@"top2",@"top3", nil];
    for (int i = 0; i<3; i++) {
        UIImageView *imgView =[[ UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*i, 0, self.view.bounds.size.width, 165)];
        imgView.image = [UIImage imageNamed:[arr objectAtIndex:i]];
        [topScl addSubview:imgView];
    }
    
    
    UIImageView *imageView =[[ UIImageView alloc]initWithFrame:CGRectMake(0, 165, self.view.bounds.size.width, 811)];
    imageView.image = [UIImage imageNamed:@"测试－列表_02"];
    [scrol addSubview:imageView];
    
    
//    JDSideMenu * jd =(JDSideMenu *)self.parentViewController;
//    [jd showMenuAnimated:YES];
    
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

-(NSString*)titleForChildControllerMDMenuViewController:(MDMenuViewController *)menuController
{
    return @"测试";
}
-(NSString*)iconForChildControllerMDMenuViewController:(MDMenuViewController *)menuController
{
    return @"ceshi.png";
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

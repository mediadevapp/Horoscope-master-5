//
//  ThirdViewController.m
//  Demo4
//
//  Created by Satellite on 14/11/27.
//  Copyright (c) 2014年 Satellite. All rights reserved.
//

#import "ZoneViewController.h"

@implementation ZoneViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view, typically from a nib.
    [self buildTopviewWithBackButton:YES title:@"星友圈" rightImage:@"发布－正常"];
    
    
//    [self setTopViewWithTitle:@"星友圈.png" withBackButton:YES];
    
//    KScreenHeight
    
//    [self buildScrollViewWithFrame:self.view.bounds contentSize:CGSizeMake(KScreenWidth, KScreenHeight) Image:@"星友圈.png"];
    [self buildScrollViewWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64) contentSize:CGSizeMake(0, 1288) Image:@"frendloop.png"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

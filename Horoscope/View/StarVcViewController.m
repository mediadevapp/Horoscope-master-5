//
//  StarVcViewController.m
//  Horoscope
//
//  Created by 01 on 14/11/28.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import "StarVcViewController.h"

@interface StarVcViewController ()

@end

@implementation StarVcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildTopviewWithBackButton:YES title:@"星文" rightImage:@"订阅－正常"];
    
    [self buildScrollViewWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64) contentSize:CGSizeMake(0, 1231.5f) Image:@"neirong"];
    


    
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

//
//  AddFriendsViewController.m
//  Horoscope
//
//  Created by Satellite on 14/12/17.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import "AddFriendsViewController.h"
#import "SearchResultViewController.h"
@interface AddFriendsViewController ()
{
    UITextField *searchTf;
    NSMutableArray *infoArr;
}
@end

@implementation AddFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self buildTopviewWithBackButton:NO title:@"添加好友" rightImage:@""];
    [self setTopViewWithTitle:@"添加好友" withBackButton:YES];
    self.view.backgroundColor = kColorWithRGB(220, 220, 220, 1);
    searchTf= [[ UITextField alloc]initWithFrame:CGRectMake(10, KISHighVersion_7?74:54, KScreenWidth-80, 34)];
    searchTf.placeholder = @"通过星缘号查找";
    searchTf.borderStyle = UITextBorderStyleLine;
    searchTf.tag = 10000111;
    searchTf.delegate = self;
    [self.view addSubview:searchTf];
    
    UIButton *button = [[UIButton alloc]init];
    button.frame = CGRectMake(sx(searchTf)+10, KISHighVersion_7?74:54, 50, 30);
    button.backgroundColor = [UIColor grayColor];
    [button addTarget:self action:@selector(cancelKeyBoard:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"搜索" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
//    NSArray *imgArr = [NSArray arrayWithObjects:@"shouji",@"weixin",@"QQ",@"weibo", nil];
//    NSArray *textArr = [NSArray arrayWithObjects:@"通讯录好友",@"微信好友",@"QQ好友",@"微博好友", nil];
//    for (int i = 0; i<4; i++) {
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, sy(searchTf)+30+i*80, KScreenWidth, 80)];
//        view.backgroundColor = [UIColor whiteColor];
//        UIView *customView =[[ UIView alloc]initWithFrame:CGRectMake(0, 79, KScreenWidth, 1)];
//        customView.backgroundColor = [UIColor grayColor];
//        [view addSubview:customView];
//        
//        
//        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 60, 60)];
//        imageView.image = KUIImage(imgArr[i]);
//        [view addSubview:imageView];
//        
//        UILabel *lb = [self buildLabelWithFrame:CGRectMake(sx(imageView)+10, 0, 200, 60) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentLeft text:nil];
//        [view addSubview:lb];
//        [self.view addSubview:view];
//        lb.text = textArr[i];
//        
//    }
    
    infoArr  = [NSMutableArray array] ;
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    self.hud.labelText = @"获取中...";
    [self.view addSubview:self.hud];
}

//回收键盘


-(void)cancelKeyBoard:(id)sender
{
    UITextField *tf = (UITextField*)[self.view viewWithTag:10000111];
    [tf resignFirstResponder];
    [self getInfoFromNetWithString:tf.text];
}

#pragma mark ---获取网络数据

-(void)getInfoFromNetWithString:(NSString *)str
{
    [self.hud show:YES];
    NSString *urlStr =[NSString stringWithFormat:@"finduserbyname?name=%@",str];

    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[AFAppDotNetAPIClient sharedClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self.hud hide:YES];
        if (![responseObject isKindOfClass:[NSArray class]]) {
            return ;
        }
            [infoArr removeAllObjects];
        [infoArr addObjectsFromArray:responseObject];
        if (infoArr.count<1) {
            [self showAlertViewWithtitle:@"提示" message:@"查无此人,请输入精确信息"];
            return;
        }
        SearchResultViewController *searchVC = [[SearchResultViewController alloc]init];
        
        searchVC.infoArray =[NSMutableArray arrayWithArray:infoArr];
        
        [self.menuController pushViewController:searchVC withTransitionAnimator:[MDTransitionAnimatorFactory transitionAnimatorWithType:MDAnimationTypeSlideFromRight]];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.hud hide:YES];
        [self showAlertViewWithtitle:@"提示" message:@"请求失败"];
    }];
}
- (void)dealloc
{
    searchTf.delegate = nil; 
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

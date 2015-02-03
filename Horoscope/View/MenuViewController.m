//
//  MenuViewController.m
//  Horoscope
//
//  Created by 01 on 14/11/25.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import "MenuViewController.h"
#import "FindViewController.h"
#import "FriendLoopViewController.h"
#import "StarDicController.h"
#import "TodayViewController.h"
#import "ZoneViewController.h"
#import "UIViewController+JDSideMenu.h"
#import "StarVcViewController.h"
#import "TestViewController.h"
#import "JDSideMenu.h"
#import "FoundViewController.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "FriendsViewController.h"

#import "NewMainViewController.h"
#import "TodayLuckViewController.h"
#import "BdViewController.h"
#import "XWViewController.h"
#import "MineViewController.h"

@interface MenuViewController ()
{
    UIButton * newsButton;
    UIButton * saysBtton;
}

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self layoutViews];
    [self.showView setHidden:YES];
    [self.newsView setHidden:YES];
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    // Do any additional setup after loading the view from its nib.
}

- (void) layoutViews
{
    
    //星座资讯 布局
    for (int i=0 ; i<5; i++) {
        newsButton =[UIButton buttonWithType:UIButtonTypeSystem];
        //       button.frame =CGRectMake(self.superShow.frame.origin.x, self.superShow.frame.origin.y+55*(i+1), self.superShow.frame.size.width, self.superShow.frame.size.height);
        
        
        newsButton.frame =CGRectMake(0+self.view.bounds.size.width, 0+50*i, self.superShow.frame.size.width, self.superShow.frame.size.height-10);
        newsButton.tag =10+i;
        
        //        button.frame =CGRectMake(0 , 0, 320, 100);
        newsButton.titleLabel.text =[NSString stringWithFormat:@"------%d",i];
        
        [newsButton setBackgroundImage:    [UIImage imageNamed:[NSString stringWithFormat:@"news%d",i]] forState:UIControlStateNormal];
        [newsButton addTarget:self action:@selector(changeViews:) forControlEvents:UIControlEventTouchUpInside];
        [self.newsView addSubview:newsButton];
        
        self.newsView.backgroundColor =[UIColor clearColor];

    }

    
    //星友说布局
    
    for (int i=0 ; i<3; i++) {
        saysBtton =[UIButton buttonWithType:UIButtonTypeSystem];
        //       button.frame =CGRectMake(self.superShow.frame.origin.x, self.superShow.frame.origin.y+55*(i+1), self.superShow.frame.size.width, self.superShow.frame.size.height);
        
//        NSLog(@"%@", self.superShow.frame);
        
        saysBtton.frame =CGRectMake(0+self.view.bounds.size.width, 0+50*i, self.superShow.frame.size.width, self.superShow.frame.size.height-10);
        saysBtton.tag =20+i;
        
        //        button.frame =CGRectMake(0 , 0, 320, 100);
        saysBtton.titleLabel.text =[NSString stringWithFormat:@"------%d",i];
        
        [saysBtton setBackgroundImage:    [UIImage imageNamed:[NSString stringWithFormat:@"say%d",i]] forState:UIControlStateNormal];
        [saysBtton addTarget:self action:@selector(changeViews:) forControlEvents:UIControlEventTouchUpInside];
        [self.showView addSubview:saysBtton];
        
        self.showView.backgroundColor =[UIColor clearColor];
       

        
    }

    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//星座资讯
- (IBAction)news:(id)sender
{
      for (int i=0 ; i<5; i++) {
    [UIView animateWithDuration:0.5+i*0.1 animations:^{
        
   
         
         UIButton * button =(UIButton * )[self.view viewWithTag:i+10];
        button.frame =CGRectMake(0, 0+50*i, self.superShow.frame.size.width, self.superShow.frame.size.height-10);
         
//        NSTimer * timeer= [NSTimer scheduledTimerWithTimeInterval:i+10 target:self selector:@selector(<#selector#>) userInfo:<#(id)#> repeats:<#(BOOL)#>]
        

    } completion:^(BOOL finished) {
        
        
    }];
          
           };
    
//    huanyuan
    
    //    还原
    [UIView animateWithDuration:0.5 animations:^{
        
        for (int i=0 ; i<4; i++) {
            
            UIButton * button =(UIButton * )[self.view viewWithTag:i+20];
            button.frame =CGRectMake(0+self.view.bounds.size.width+self.view.bounds.size.width, 0+50*i, self.superShow.frame.size.width, self.superShow.frame.size.height-10);
        }
        
    } completion:^(BOOL finished) {
    }];

    

    [_newsView setHidden:NO];
    [_showView setHidden:YES];
    
   
}

- (void)changeViews:(UIButton *)btn
{
    
        StarDicController * starVC =[[StarDicController alloc]init];
        FoundViewController * findVC =[[FoundViewController alloc]init];
    UINavigationController *findNav = [[UINavigationController alloc]initWithRootViewController:findVC];
    findNav.navigationBarHidden = YES;
//        FriendLoopViewController * friendLoop =[[FriendLoopViewController alloc]init];
    
    
    FriendsViewController * friendLoop = [[FriendsViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:friendLoop];
    nav.navigationBarHidden = YES;

//        TodayViewController * todayVC =[[TodayViewController alloc]init];
    TodayLuckViewController *todayVC =[[TodayLuckViewController alloc]init];
        ZoneViewController * zoneVC =[[ZoneViewController alloc]init];
    
    StarVcViewController *svc= [[StarVcViewController alloc]init];
    
    TestViewController *testVC =[[TestViewController alloc]init];
    
    LoginViewController * loginVC =[[LoginViewController alloc]init];
    
    
    
    switch (btn.tag) {
            //星咨询 10开头
        case 10:
//            运势
            
    [self.sideMenuController setContentController:todayVC animated:YES];
            
            break;
        case 11:
            
//   FindViewController * starVC =[FindViewController alloc]init];
//            宝典
    [self.sideMenuController setContentController:starVC animated:YES];
            
            break;
        case 12:
            
//            星文
    [self.sideMenuController setContentController:svc animated:YES];
            break;
        case 13:
            
            //测试
    [self.sideMenuController setContentController:testVC animated:YES];
            break;
            
            
        case 14:
            
            //注册
            
            
 
            [self.sideMenuController setContentController:loginVC animated:YES];
            
            [btn setTitle:@"testsets" forState:UIControlStateNormal];
            
            
            
            break;
            

            
            
//            星友说 20开头
        case 20:
//            发现
            
    [self.sideMenuController setContentController:findNav animated:YES];
            break;
        case 21:
//星友
            
            friendLoop.title =@"星友";
     [self.sideMenuController setContentController:nav animated:YES];
            break;
        case 22:
//            朋友圈
    [self.sideMenuController setContentController:zoneVC animated:YES];
            break;
            
            
            
        default:
            break;
    }
    
    
}
//星友说
- (IBAction)friendSay:(id)sender
{
    
//滑动动画
      for (int i=0 ; i<3; i++) {
    [UIView animateWithDuration:0.5+i*0.1 animations:^{
         UIButton * button =(UIButton * )[self.view viewWithTag:i+20];
            button.frame =CGRectMake(0, 0+50*i, self.superShow.frame.size.width, self.superShow.frame.size.height-10);
       
        
    } completion:^(BOOL finished) {
    }];
     }
//    还原
    [UIView animateWithDuration:0.5 animations:^{
        
        for (int i=0 ; i<4; i++) {
            
            UIButton * button =(UIButton * )[self.view viewWithTag:i+10];
            button.frame =CGRectMake(0+self.view.bounds.size.width, 0+50*i, self.superShow.frame.size.width, self.superShow.frame.size.height-10);
        }
        
    } completion:^(BOOL finished) {
    }];
    
    [_newsView setHidden:YES];
    [_showView setHidden:NO];
    
    
}
//达人秀

- (IBAction)superShown:(id)sender
{
//    MainViewController *mainVC =[[ MainViewController alloc]init];
    NewMainViewController *mainVC = [[NewMainViewController alloc]init];
    
    [self.sideMenuController setContentController:mainVC animated:YES];
    
    [_showView setHidden:YES];
    [_newsView setHidden:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didClickMine:(UIButton *)sender {
    
    MineViewController *mineVC = [[MineViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:mineVC];
    mineVC.isRootView =YES;
    navi.navigationBarHidden = YES;
    [self.sideMenuController setContentController:navi animated:YES];
    [_showView setHidden: YES];
    [_newsView setHidden: YES];
    
    
    
}
@end

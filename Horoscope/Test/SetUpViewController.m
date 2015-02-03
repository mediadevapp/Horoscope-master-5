//
//  SetUpViewController.m
//  Horoscope
//
//  Created by Satellite on 14/12/18.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import "SetUpViewController.h"
#import "SetUpCell.h"
#import "PassWordChangeViewController.h"
#import "SafeViewController.h"
#import "BangdingViewController.h"
#import "NotifiationViewController.h"s
#import "PrivacyViewController.h"
#import "FeedbackViewController.h"
#import "AboutMeViewController.h"
@interface SetUpViewController ()
{
    UITableView * myTableView;
    NSArray * titleArr;
}
@end

@implementation SetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    [self buildTopviewWithBackButton:NO title:@"设置" rightImage:@""];
    
    [self setTopViewWithTitle:@"个人设置" withBackButton:YES];
    
    self.view.backgroundColor = [UIColor whiteColor];
    myTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, KISHighVersion_7?64:44, KScreenWidth, KScreenHeight-(KISHighVersion_7?64:44)) style:UITableViewStylePlain];
    myTableView.bounces = NO;
    myTableView.delegate = self;
    myTableView.dataSource = self;

    [self setExtraCellLineHidden:myTableView];
    [self.view addSubview:myTableView];
    
    
//    [self v]
//    titleArr = [NSArray arrayWithObjects:@"账号安全",@"账号绑定",@"消息提醒",@"隐私",@"黑名单",@"清理缓存",@"关于",@"反馈意见",@"给我评分",@"退出账号", nil];
    
    titleArr = [NSArray arrayWithObjects:@"账号安全",@"关于",@"反馈意见",@"退出账号", nil];

    
    
}

-(void)backToLastPage:(id)sender
{
    
    [self.menuController popViewControllerAnimated:YES];
    //    [self.navigationController popViewControllerAnimated:YES];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    return 5;
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    switch (section) {
//        case 0:
//            return 2;
//            break;
//        case 1:
//            return 2;
//            break;
//        case 2:
//            return 2;
//            break;
//        case 3:
//            return 3;
//            break;
//        default:
//            return 1;
//            break;
//    }
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        default:
            return 1;
            break;
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    SetUpCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (!cell) {
        cell = [[SetUpCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    
//    NSArray *ar =[NSArray arrayWithObjects:@"qq绑定图标大",@"微信绑定图标大",@"微博绑定图标大",@"手机绑定图标大", nil];
//    
//    //        if (self.isHaveImg) {
//    for (int i = 0; i<4; i++) {
//        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth-180+30*i+5, 5, 30, 30)];
//        img.image = KUIImage(ar[i]);
//        //                img.backgroundColor = [UIColor redColor];
//        [cell addSubview:img];
//        if (indexPath.section==0&&indexPath.row==1) {
//            img.hidden = NO;
//        }else{
//            img.hidden = YES;
//        }
//    }

//    cell.titleLabel.text = @"1";//[titleArr objectAtIndex:(2*indexPath.section+indexPath.row)];
    
    switch (indexPath.section) {
        case 0:
         cell.titleLabel.text = @"账号安全";
            cell.accessoryType = YES;
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    cell.titleLabel.text = @"关于";
                    break;
                default:
                    cell.titleLabel.text = @"意见反馈";
                    break;
            }
            cell.accessoryType = YES;
            break;
        default:
            cell.titleLabel.text = @"退出登录";
            cell.accessoryType = NO;
            break;
            
    }
    
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SafeViewController *safe = [[SafeViewController alloc]init];
//    BangdingViewController *bd = [[BangdingViewController alloc]init];
//    NotifiationViewController *not = [[NotifiationViewController alloc]init];
//    PrivacyViewController *priv = [[PrivacyViewController alloc]init];
    FeedbackViewController *fee =[[FeedbackViewController alloc]init];
    
    AboutMeViewController *aboutVC = [[AboutMeViewController alloc]init];
    switch (indexPath.section) {
        case 0:
                    [self.menuController pushViewController:safe withTransitionAnimator:[MDTransitionAnimatorFactory transitionAnimatorWithType:MDAnimationTypeSlideFromRight]];
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    [self.menuController pushViewController:aboutVC withTransitionAnimator:[MDTransitionAnimatorFactory transitionAnimatorWithType:MDAnimationTypeSlideFromRight]];
                    break;
                    case 1:
                    [self.menuController pushViewController:fee withTransitionAnimator:[MDTransitionAnimatorFactory transitionAnimatorWithType:MDAnimationTypeSlideFromRight]];
                    break;
                default:
                    break;
            }
            
            break;
        case 2:
            [self offLine];
            [self showMessageWindowWithContent:@"您已经登出" imageType:0];
            [self.menuController popViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"GETOUTLOIGN" object:nil];
            break;
        case 3:

//            switch (indexPath.row) {
//                case 1:
//                    [self.menuController pushViewController:fee withTransitionAnimator:[MDTransitionAnimatorFactory transitionAnimatorWithType:MDAnimationTypeSlideFromRight]];
//                    break;
//                    
//                default:
//                    break;
//            }
            break;
//        case 4:
//
//            break;
        default:
            break;
    }    
}
-(void)offLine
{
    [[UserCache sharedInstance]removeObjectForKey:KMYUSERID];
    [[UserCache sharedInstance]removeObjectForKey:MYINFODICT];
 
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
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

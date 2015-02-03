//
//  FoundViewController.m
//  Horoscope
//
//  Created by Satellite on 14/12/17.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import "FoundViewController.h"
#import "FriendsCell.h"
#import "DefaultMenuView.h"
#import "MineViewController.h"

#define kUrl @"finduser?uid="

@interface FoundViewController ()
{
    UITableView *myTabelView;
    NSMutableArray * infoArray;
}
@end

@implementation FoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.menuController.topBar setHidden:YES];
    
    if (self.isFriends) {
        [self setTopViewWithTitle:@"发现" withBackButton:YES];
    }else{
    [self buildTopviewWithBackButton:NO title:@"发现" rightImage:@"screening"];
    }
    
    // Do any additional setup after loading the view.
    myTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, KISHighVersion_7?64:44, KScreenWidth, KScreenHeight-(KISHighVersion_7?64:44))];
    
    myTabelView.delegate = self;
    myTabelView.dataSource = self;
    myTabelView.rowHeight = 90;
    
    [self.view addSubview:myTabelView];
    infoArray =[NSMutableArray array];
   }

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self getInfoFromNet];
}
#pragma  mark ---网络请求
-(void)getInfoFromNet
{
      [[AFAppDotNetAPIClient sharedClient] GET:[kUrl stringByAppendingString:[[UserCache sharedInstance]objectForKey:KMYUSERID]] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"get----%@",responseObject);
        
        if (![responseObject isKindOfClass:[NSArray class]]) {
            return ;
        }
        [infoArray removeAllObjects];
        [infoArray addObjectsFromArray:responseObject];
        [myTabelView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error---%@",error);
    }];
    
    
}


#pragma mark  -----关注请求

-(void)getFollowWithFid:(NSString *)fid
{
    
    if (![[UserCache sharedInstance]objectForKey:KMYUSERID])
    {
        [self showAlertViewWithtitle:@"提示" message:@"您还未登录"];
    }else{
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[[UserCache sharedInstance]objectForKey:KMYUSERID] forKey:@"uid"];
    [dic setObject:fid forKey:@"fid"];
    
    [[AFAppDotNetAPIClient sharedClient]POST:@"follow" parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"成功");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"失败");
    }];
    }
}

-(void)didClickFollowWithCell:(FriendsCell *)cell
{
    NSDictionary *dic = [infoArray objectAtIndex:cell.tag];
    [self getFollowWithFid:KISDictionaryHaveKey(dic, @"uid")];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section==0) {
//        return 2;
//    }
    return infoArray.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *identifier = @"cell";
        FriendsCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[FriendsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
    cell.tag = indexPath.row;
    cell.delegate = self;
    NSDictionary *dic = [infoArray objectAtIndex:indexPath.row];
    cell.headimgView.placeholderImage = KUIImage(@"placeholder.jpg");
    cell.headimgView.imageURL = [NSURL URLWithString:KISDictionaryHaveKey(dic, @"photo")];
        cell.nameLb.text = KISDictionaryHaveKey(dic, @"nickname");
        cell.starImgView.image = KUIImage([self GetNameReturnImageWithName:KISDictionaryHaveKey(dic, @"xing")]);
        cell.starLb.text = KISDictionaryHaveKey(dic, @"xing");;
    cell.sexImg.image = KUIImage(@"sexImg");

        cell.signatureLb.text =KISDictionaryHaveKey(dic, @"phrase");;
        cell.timeLabel.text = @"1分钟前";
        return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = infoArray[indexPath.row];
    
    MineViewController *mine = [[MineViewController alloc]init];
    mine.isRootView = NO;
    mine.userid = KISDictionaryHaveKey(dic, @"uid");
//    [self.menuController pushViewController:mine withTransitionAnimator:[MDTransitionAnimatorFactory transitionAnimatorWithType:MDAnimationTypeSlideFromRight]];
    
    [self.menuController pushViewController:mine withTransitionAnimator:[MDTransitionAnimatorFactory transitionAnimatorWithType:MDAnimationTypeSlideFromRight]];
    
//        [self.navigationController pushViewController:mine animated:YES];

}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        return @"为您推荐";
    }else {
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        return 25;
    }else{
        return 10;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    myTabelView.delegate = nil;
    myTabelView.dataSource = nil;
}

-(NSString*)titleForChildControllerMDMenuViewController:(MDMenuViewController *)menuController
{
    return @"发现";
}
-(NSString*)iconForChildControllerMDMenuViewController:(MDMenuViewController *)menuController
{
    return @"faxian.png";
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

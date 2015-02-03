//
//  FriendsViewController.m
//  Horoscope
//
//  Created by Satellite on 14/12/17.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import "FriendsViewController.h"
#import "FriendsCell.h"
#import "TopTableViewCell.h"
#import "AddFriendsViewController.h"
#import "MineViewController.h"
#import "ActivityViewController.h"
#import "AddressBookViewController.h"
#import "FoundViewController.h"
@interface FriendsViewController ()
{
    UITableView *myTabelView;
    NSArray *nameArr;
    NSArray *imgArr;
    NSMutableArray * infoArr;
    NSMutableDictionary * infoDic;
    UIView * ysView;
    UIImageView * ysImgView;
    NSMutableArray * ysArr;
    UIButton * titleBtn;
    
}
@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildTopviewWithBackButton:NO title:@"" rightImage:@""];
    ysArr = [NSMutableArray arrayWithObjects:@"我关注的",@"我的粉丝", nil];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshList:) name:@"followSuccess--wx" object:nil];
    
    titleBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, KISHighVersion_7?20:0, KScreenWidth-100, 40)];
    [titleBtn setTitle:@"我关注的▼" forState:UIControlStateNormal];
    titleBtn.backgroundColor =[ UIColor clearColor];
    [titleBtn addTarget:self action:@selector(changeTitle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:titleBtn];

    
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-60, KISHighVersion_7?20:0, 60, 44)];
    [button setImage:KUIImage(@"123123") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(enterNextPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    
    // Do any additional setup after loading the view.
    myTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, KISHighVersion_7?64:44, KScreenWidth, KScreenHeight-(KISHighVersion_7?64:44))];
    
    myTabelView.delegate = self;
    myTabelView.dataSource = self;
    myTabelView.rowHeight = 90;
    [self.view addSubview:myTabelView];
    
    nameArr = [NSArray arrayWithObjects:@"通讯录",@"新朋友",@"活动", nil];
    imgArr =[NSArray arrayWithObjects:@"xinpingyou",@"dianhualianxiren",@"dianhualianxiren", nil];

    infoArr = [NSMutableArray array];
    infoDic = [NSMutableDictionary dictionary];
    
    [self buildYsView];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSString *str = [NSString stringWithFormat:@"userfollow.php?uid=%@",[[UserCache sharedInstance]objectForKey:KMYUSERID]];
    [self getInfoFromNetWithUrl:str];
    
}


-(void)buildYsView
{
    ysView = [[UIView alloc]initWithFrame:CGRectMake(0, KISHighVersion_7?64:44, KScreenWidth, KScreenHeight-(KISHighVersion_7?64:44))];
    ysView.backgroundColor = kColorWithRGB(0, 0, 0, 0.5);
    ysView.hidden = YES;
    [self.view addSubview:ysView];
    
    ysImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 73)];
    ysImgView.image = KUIImage(@"ys_c_down");
    ysImgView.center = CGPointMake(KScreenWidth/2, -37);
    ysImgView.userInteractionEnabled = YES;
    [ysView addSubview:ysImgView];
    
    for (int i = 0; i<2; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, i*36, 100, 36)];
        [btn setTitle:ysArr[i] forState:UIControlStateNormal];
        [btn setTag: 1000+i];
        [btn addTarget:self action:@selector(changeYsTitle:) forControlEvents:UIControlEventTouchUpInside];
        [ysImgView addSubview:btn];
    }
}

#pragma  mark ---网络请求
-(void)getInfoFromNetWithUrl:(NSString *)url
{
      [[AFAppDotNetAPIClient sharedClient] GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
 
        NSLog(@"get----%@",responseObject);
        
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            infoDic = responseObject;
            [myTabelView reloadData];
        }else if ([responseObject isKindOfClass:[NSArray class]])
        {
            [infoArr removeAllObjects];
            [infoArr addObjectsFromArray:responseObject];
            [myTabelView reloadData];
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error---%@",error);
    }];
    
 
}

-(void)refreshList:(NSNotification *)info
{
    [self getInfoFromNetWithUrl:[[UserCache sharedInstance]objectForKey:KMYUSERID]];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    return [infoDic allKeys].count+1;
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 3;
    }else
    
//    NSArray *keysArr = [infoDic allKeys];
//    keysArr = [keysArr sortedArrayUsingSelector:@selector(compare:)];
//    
//    NSArray *arr = [infoDic objectForKey:keysArr[section]];
//    return arr.count;
    return infoArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section ==0) {
        static NSString * identifier = @"adfasdf";
        TopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[TopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.headimgView.image = KUIImage(imgArr[indexPath.row]);
        cell.nameLb.text = nameArr[indexPath.row];
        cell.accessoryType = YES;
        return cell;
        
    }else{
        static NSString *identifier = @"cell";
        FriendsCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[FriendsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        NSDictionary *dic =[infoArr objectAtIndex:indexPath.row];
        
        cell.headimgView.imageURL =[NSURL URLWithString:KISDictionaryHaveKey(dic, @"photo")] ;
        cell.nameLb.text = KISDictionaryHaveKey(dic, @"nickname");
        cell.starImgView.image = KUIImage([self GetNameReturnImageWithName:KISDictionaryHaveKey(dic, @"xing")]);
        cell.starLb.text = KISDictionaryHaveKey(dic, @"xing");
        cell.sexImg.image = KUIImage(@"sexImg");
        
        cell.signatureLb.text =KISDictionaryHaveKey(dic, @"phrase");
        cell.timeLabel.text = @"1分钟前";
        cell.gzBtn.hidden = YES;
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section ==0) {
        if (indexPath.row ==0) {
            AddressBookViewController *address = [[AddressBookViewController alloc]init];
            [self.menuController pushViewController:address withTransitionAnimator:[MDTransitionAnimatorFactory transitionAnimatorWithType:MDAnimationTypeSlideFromRight]];
        }
        else if (indexPath.row ==1)
        {
            FoundViewController *address = [[FoundViewController alloc]init];
            
            address.isFriends = YES;
            [self.menuController pushViewController:address withTransitionAnimator:[MDTransitionAnimatorFactory transitionAnimatorWithType:MDAnimationTypeSlideFromRight]];
        }
        if (indexPath.row ==2) {
            ActivityViewController *activC =[[ActivityViewController alloc]init];
            [self.menuController pushViewController:activC withTransitionAnimator:[MDTransitionAnimatorFactory transitionAnimatorWithType:MDAnimationTypeSlideFromRight]];
        }
    }
    else  if (indexPath.section ==1) {
        MineViewController *mine = [[MineViewController alloc]init];
        mine.isRootView = NO;
        NSDictionary *dic =[infoArr objectAtIndex:indexPath.row];
        mine.userid = KISDictionaryHaveKey(dic, @"uid");
        [self.menuController pushViewController:mine withTransitionAnimator:[MDTransitionAnimatorFactory transitionAnimatorWithType:MDAnimationTypeSlideFromRight]];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        return @"✨";
    }else
    return @"";
}

-(void)enterNextPage:(id)sender
{
    AddFriendsViewController *add =[[AddFriendsViewController alloc]init];
    [self.menuController pushViewController:add withTransitionAnimator:[MDTransitionAnimatorFactory transitionAnimatorWithType:MDAnimationTypeSlideFromRight]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)changeTitle:(UIButton *)sender
{
    ysView.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        ysImgView.center = CGPointMake(KScreenWidth/2, 37);
    } completion:^(BOOL finished) {
        [ysView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenYsView:)]];
    }];
    
}

-(void)changeYsTitle:(UIButton *)sender
{
    [titleBtn setTitle:[NSString stringWithFormat:@"%@▼", ysArr[sender.tag-1000]] forState:UIControlStateNormal];
    NSString *userid = [[UserCache sharedInstance]objectForKey:KMYUSERID];
   if (sender.tag-1000==0){
       NSString *url = @"userfollow.php?uid=";

        [self getInfoFromNetWithUrl:[url stringByAppendingString:userid]];
    }
    else{
        NSString *url = @"userfans.php?uid=";

        [self getInfoFromNetWithUrl:[url stringByAppendingString:userid]];
    }
    
    
    [UIView animateWithDuration:0.3 animations:^{
        ysImgView.center = CGPointMake(KScreenWidth/2, -37);
    } completion:^(BOOL finished) {
        ysView.hidden = YES;
        [ysView removeGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenYsView:)]];
    }];
    
}

-(void)hiddenYsView:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        ysImgView.center = CGPointMake(KScreenWidth/2, -37);
    } completion:^(BOOL finished) {
        ysView.hidden = YES;
        [ysView removeGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenYsView:)]];
        
    }];
}

-(NSString*)titleForChildControllerMDMenuViewController:(MDMenuViewController *)menuController
{
    return @"星友";
}
-(NSString*)iconForChildControllerMDMenuViewController:(MDMenuViewController *)menuController
{
    return @"xingyou.png";
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

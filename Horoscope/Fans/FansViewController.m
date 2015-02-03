//
//  FansViewController.m
//  Horoscope
//
//  Created by Satellite on 14/12/23.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import "FansViewController.h"
#import "FriendsCell.h"
#import "MineViewController.h"
@interface FansViewController ()
{
    UITableView * myTableView;
    NSMutableArray *  infoArr;
    
}
@end

@implementation FansViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isFans) {
        [self setTopViewWithTitle:@"粉丝" withBackButton:YES];
    }else{
        [self setTopViewWithTitle:@"关注" withBackButton:YES];

    }
    
    myTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, KISHighVersion_7?64:44, KScreenWidth, KScreenHeight-(KISHighVersion_7?64:44)) style:UITableViewStylePlain];
    myTableView.bounces = NO;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.rowHeight = 90;
    
    [self.view addSubview:myTableView];
    infoArr =[ NSMutableArray array];
    
    [self getInfoFromNet];
    
    // Do any additional setup after loading the view.
}

-(void)getInfoFromNet
{
    NSString *urlStr ;
    if (self.isFans) {
        urlStr =[NSString stringWithFormat:@"userfans.php?uid=%@",[[UserCache sharedInstance]objectForKey:KMYUSERID]];
    }else{
        urlStr =[NSString stringWithFormat:@"userfollow.php?uid=%@",[[UserCache sharedInstance]objectForKey:KMYUSERID]];
    }
    
      [[AFAppDotNetAPIClient sharedClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (![responseObject isKindOfClass:[NSArray class]]) {
            return ;
        }
        [infoArr addObjectsFromArray:responseObject];
        [myTableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return infoArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    FriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier ];
    
    if (!cell) {
        cell = [[FriendsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSDictionary *dic = [infoArr objectAtIndex:indexPath.row];
    
    cell.headimgView.placeholderImage = KUIImage(@"placeholder.jpg");
    cell.headimgView.imageURL = [NSURL URLWithString:KISDictionaryHaveKey(dic, @"photo")];
    cell.nameLb.text = KISDictionaryHaveKey(dic, @"nickname");
    cell.starImgView.image = KUIImage(@"ys_c_by");
    cell.starLb.text = KISDictionaryHaveKey(dic, @"xing");
    cell.sexImg.image = KUIImage(@"sexImg");
    cell.signatureLb.text =KISDictionaryHaveKey(dic, @"phrase");
    cell.timeLabel.text = @"1分钟前";
    cell.gzBtn.hidden = YES;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [infoArr objectAtIndex:indexPath.row];
    MineViewController *mineVC = [[MineViewController alloc]init];
    mineVC.isRootView = NO;
    mineVC.userid = KISDictionaryHaveKey(dic, @"uid");
    [self.menuController pushViewController:mineVC withTransitionAnimator:[MDTransitionAnimatorFactory transitionAnimatorWithType:MDAnimationTypeSlideFromRight]];
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

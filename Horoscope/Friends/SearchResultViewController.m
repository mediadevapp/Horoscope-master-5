//
//  SearchResultViewController.m
//  Horoscope
//
//  Created by Satellite on 14/12/25.
//
//

#import "SearchResultViewController.h"
#import "MineViewController.h"
@interface SearchResultViewController ()
{
    UITableView *myTabelView;
   
}
@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTopViewWithTitle:@"搜索结果" withBackButton:YES];
    
    
    myTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, KISHighVersion_7?64:44, KScreenWidth, KScreenHeight-(KISHighVersion_7?64:44))];
    
    myTabelView.delegate = self;
    myTabelView.dataSource = self;
    myTabelView.rowHeight = 90;
    [self.view addSubview:myTabelView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return self.infoArray.count;    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        static NSString *identifier = @"cell";
        FriendsCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[FriendsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
      }
    NSDictionary *dic = [self.infoArray objectAtIndex:indexPath.row];
    cell.delegate = self;
    cell.headimgView.placeholderImage = KUIImage(@"placeholder.jpg");
    cell.headimgView.imageURL = [NSURL URLWithString:KISDictionaryHaveKey(dic, @"photo")];
    cell.nameLb.text = KISDictionaryHaveKey(dic, @"nickname");
    cell.starImgView.image = KUIImage(@"ys_c_by");
    cell.starLb.text = KISDictionaryHaveKey(dic, @"xing");
    cell.sexImg.image = KUIImage(@"sexImg");
    cell.signatureLb.text =KISDictionaryHaveKey(dic, @"phrase");
    cell.timeLabel.text = @"1分钟前";
    cell.gzBtn.hidden = NO;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = self.infoArray[indexPath.row];
    
        MineViewController *mine = [[MineViewController alloc]init];
        mine.isRootView = NO;
    mine.userid =KISDictionaryHaveKey(dic, @"uid");
        [self.menuController pushViewController:mine withTransitionAnimator:[MDTransitionAnimatorFactory transitionAnimatorWithType:MDAnimationTypeSlideFromRight]];
}

-(void)didClickFollowWithCell:(FriendsCell *)cell
{
    NSDictionary *dic = [self.infoArray objectAtIndex:cell.tag];
    [self getFollowWithFid:KISDictionaryHaveKey(dic, @"uid")];

}
#pragma mark  -----关注请求

//-(void)getFollowWithFid:(NSString *)fid
//{
//
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setObject:[[UserCache sharedInstance]objectForKey:KMYUSERID] forKey:@"uid"];
//    [dic setObject:fid forKey:@"fid"];
//    
//    [[AFAppDotNetAPIClient sharedClient]POST:@"follow" parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"成功");
//        
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"followSuccess--wx" object:nil];
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"失败");
//    }];
//    
//}
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

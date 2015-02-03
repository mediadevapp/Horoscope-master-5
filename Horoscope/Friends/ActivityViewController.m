//
//  ActivityViewController.m
//  Horoscope
//
//  Created by Satellite on 14/12/27.
//
//

#import "ActivityViewController.h"
#import "ActivityCell.h"
#import "TastCell.h"
#import "ActivityContentViewController.h"
@interface ActivityViewController ()
{
    UITableView * myTableView;
    NSMutableArray *infoArray;
}
@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTopViewWithTitle:@"活动" withBackButton:YES];
    
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KTopHeight, KScreenWidth,KScreenHeight-(KISHighVersion_7?64:44)) style:UITableViewStylePlain];
    
    myTableView.delegate =self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    infoArray = [NSMutableArray array];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    self.hud.labelText = @"获取中...";
    [self.view addSubview:self.hud];
    
    [self getInfoFromNet];
    
    // Do any additional setup after loading the view.
}

-(void)getInfoFromNet
{
    NSString *urlStr  = @"eventslist";
   [[AFAppDotNetAPIClient sharedClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (![responseObject isKindOfClass:[NSArray class]]) {
            return ;
        }
        [infoArray addObjectsFromArray:responseObject];
        [myTableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return infoArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    TastCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier ];
    
    if (!cell) {
        cell = [[TastCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSDictionary *dic = [infoArray objectAtIndex:indexPath.row];
    cell.titleLabel.text = KISDictionaryHaveKey(dic, @"title");
    cell.imgView.imageURL = [NSURL URLWithString:KISDictionaryHaveKey(dic, @"photo")];
    return cell;
    
//    static NSString *identifier = @"cell";
//    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier ];
//    
//    if (!cell) {
//        cell = [[ActivityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//    NSDictionary *dic = [infoArray objectAtIndex:indexPath.row];
//    cell.topImageView.imageURL = [NSURL URLWithString:KISDictionaryHaveKey(dic, @"photo")];
//    cell.topImageView.layer.masksToBounds = YES;
//    cell.topImageView.layer.cornerRadius = 6.0;
//
//    cell.bgImgView.frame = CGRectMake(10, 40, KScreenWidth-20, 530);
//    cell.bgImgView.layer.masksToBounds = YES;
//    cell.bgImgView.layer.cornerRadius = 6.0;
//    cell.titleLb.text = [NSString stringWithFormat:@"   %@",KISDictionaryHaveKey(dic, @"title")];
//    cell.datyView1.leftLb.text = @"这会还不秀，等什么呢";
//    cell.datyView2.leftLb.text = @"一年一度的圣诞节，你收到苹果了么";
//    cell.datyView3.leftLb.text = @"圣诞节桃花运排行榜";
//    cell.datyView4.leftLb.text = @"十二星座有啥不同";
//    cell.timeLabel.text = @"2014.12.29/10:27";
//    
//    cell.datyView1.rightImgView.imageURL = [NSURL URLWithString:KISDictionaryHaveKey(dic, @"photo")];
//    cell.datyView2.rightImgView.imageURL = [NSURL URLWithString:KISDictionaryHaveKey(dic, @"photo")];
//    cell.datyView3.rightImgView.imageURL = [NSURL URLWithString:KISDictionaryHaveKey(dic, @"photo")];
//    cell.datyView4.rightImgView.imageURL = [NSURL URLWithString:KISDictionaryHaveKey(dic, @"photo")];
//    
//    
//    return cell;

    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ActivityContentViewController *act = [[ActivityContentViewController alloc]init];
    act.mainDic = [NSMutableDictionary dictionaryWithDictionary:infoArray[indexPath.row]];
    [self.menuController pushViewController:act animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    myTableView  .delegate = nil;
    myTableView.dataSource = nil;
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

//
//  CircleStarViewController.m
//  Horoscope
//
//  Created by Satellite on 15/1/5.
//
//

#import "CircleStarViewController.h"
#import "SendCircleViewController.h"
@interface CircleStarViewController ()
{
    NSMutableArray * infoArray;
    UITableView * myTableView;
    UITextField * commentTF;
    UIView * commentView;
    UIView * commentBgView;
    NSMutableDictionary * commentDict;
    float keyboardhight;
    
    NSString * myUid;
}
@end

@implementation CircleStarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildTopviewWithBackButton:NO title:@"星友圈" rightImage:nil];
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-60, KISHighVersion_7?20:0, 60, 44)];
    [button setImage:KUIImage(@"123123") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(enterNextPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    
    myUid = [[UserCache sharedInstance]objectForKey:KMYUSERID];
    
    infoArray = [NSMutableArray array];
    commentDict = [NSMutableDictionary dictionary];
    keyboardhight = 0.0;
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KISHighVersion_7?64:44, width(self.view), height(self.view)-(KISHighVersion_7?64:44)) style:UITableViewStylePlain];
    
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    [self buildTableViewHeadView];
    [self createCommentText];
    [self registerForKeyboardNotifications];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self getInfoFromNet];

}
#pragma mark ---创建头
-(void)buildTableViewHeadView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width(self.view), width(self.view)/3*2)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imgView =[[ UIImageView alloc]initWithFrame:CGRectMake(0, 0, width(self.view), width(self.view)/2)];
    imgView.image = KUIImage(@"bg-Normal");
    imgView.backgroundColor = [UIColor grayColor];
    [view addSubview:imgView];
    
    EGOImageView *headImg = [[EGOImageView alloc]initWithFrame:CGRectMake(width(self.view)-80-50, width(self.view)/2-40, 80, 80)];
    
    headImg.placeholderImage = KUIImage(@"placeholder.jpg");
    headImg.imageURL = nil;
    [view addSubview:headImg];
    
    myTableView.tableHeaderView = view;
    
    
}



#pragma mark---创建评论条
-(void)createCommentText
{
    commentBgView = [[UIView alloc]initWithFrame:CGRectMake(0, KISHighVersion_7?64:44, KScreenWidth, KScreenHeight-(KISHighVersion_7?64:44))];
    commentBgView.backgroundColor = [UIColor colorWithRed:0/225.0f green:0/225.0f blue:0/225.0f alpha:0.6];
    commentBgView.hidden = YES;
    [self.view addSubview:commentBgView];
    
    commentView = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenHeight, KScreenWidth, 55)];
    commentTF = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, KScreenWidth-20, 45)];
    commentView.backgroundColor = [UIColor whiteColor];
    commentTF.backgroundColor = [UIColor whiteColor];
    commentTF.borderStyle = UITextBorderStyleRoundedRect;
    commentTF.font = [UIFont systemFontOfSize:14];
    commentTF.adjustsFontSizeToFitWidth = YES;
    commentTF.delegate = self;
    commentTF.returnKeyType =UIReturnKeyGo;
    commentTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    commentTF.keyboardType = UIKeyboardTypeDefault;
    [commentView addSubview:commentTF];
    commentTF.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [commentBgView addSubview:commentView];
    
}


#pragma mark ---网络请求

-(void)getInfoFromNet
{
    NSString *urlStr = [NSString stringWithFormat:@"friendcontent.php?id=%@",[[UserCache sharedInstance]objectForKey:KMYUSERID]];
    [[AFAppDotNetAPIClient sharedClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (![responseObject isKindOfClass:[NSArray class]]) {
            return ;
        }
        [infoArray removeAllObjects];
        [infoArray addObjectsFromArray:responseObject];
        [myTableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self showAlertViewWithtitle:@"提示" message:@"获取失败"];
    }];
}

#pragma mark ----tableview delgate  datasourse

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return infoArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    CircleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CircleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.delegate = self;
    cell.tag = indexPath.row;
    
    
    NSDictionary *dic = [infoArray objectAtIndex:indexPath.row];
    NSString *str = KISDictionaryHaveKey(dic, @"content");
    
    CGSize size = [self labelAutoCalculateRectWith:str FontSize:14 MaxSize:CGSizeMake(KScreenWidth-80, 300)];
    
    cell.titleLabel.frame = CGRectMake(70, 35, size.width, size.height);
    
    NSString *imgStr = KISDictionaryHaveKey(dic, @"photo");
    
    if (imgStr.length>0) {
        cell.cImageView.frame = CGRectMake(70, sy(cell.titleLabel)+5,  KScreenWidth-sx(cell.headImageView)-40, 200);
        cell.timeLabel.frame = CGRectMake(sx(cell.headImageView)+10, sy(cell.cImageView)+5,150, 20);
        cell.menuBtn.frame = CGRectMake(KScreenWidth-60, sy(cell.cImageView)+5, 50, 30);

    }else{
        cell.cImageView.frame =CGRectMake(70, sy(cell.titleLabel)+5, 0, 200);
        cell.timeLabel.frame = CGRectMake(sx(cell.headImageView)+10, sy(cell.titleLabel)+5,150, 20);
        cell.menuBtn.frame = CGRectMake(KScreenWidth-60, sy(cell.titleLabel)+5, 50, 30);
        cell.zanBtn .frame=CGRectMake(sx(cell.menuBtn)-140-50, sy(cell.titleLabel)+5, 70, 30);
        cell.commBtn.frame=CGRectMake(sx(cell.zanBtn), sy(cell.titleLabel)+5, 70, 30);

    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.headImageView.imageURL = [NSURL URLWithString:KISDictionaryHaveKey(dic, @"photo")];
    cell.titleLabel.text =KISDictionaryHaveKey(dic, @"content");
    cell.nameLabel.text = KISDictionaryHaveKey(dic, @"username");
    cell.cImageView.imageURL = [NSURL URLWithString:KISDictionaryHaveKey(dic, @"photo")];
    cell.timeLabel.text = KISDictionaryHaveKey(dic, @"crtime");
//    [cell.zanBtn setTitle:KISDictionaryHaveKey(dic, @"zcount") forState:UIControlStateNormal];
//    [cell.commBtn setTitle:@"1" forState:UIControlStateNormal];
    
    cell.zanBtn.countLabel.text = KISDictionaryHaveKey(dic, @"zcount");
    cell.commBtn.countLabel.text = @"1";
    
    if ([KISDictionaryHaveKey(dic, @"zcount")intValue]>0) {
        [cell buildZanViewWithdic:nil];
    }else{
        [cell.zanView removeFromSuperview];
    }
    if (cell.tag ==5) {
        NSLog(@"%@",cell.subviews);
    }
    
    NSString *commentStr =KISDictionaryHaveKey(dic, @"comment");
    if (commentStr.length>0) {
        NSArray *arr =[NSArray array];
        arr = [self segmentationStrign:commentStr withStr:@"#"];
        [cell buildCommentViewWithDic:arr];
    }else{
        [cell buildCommentViewWithDic:nil];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    float height = 280;
    NSDictionary *dic = [infoArray objectAtIndex:indexPath.row];
    
    NSString *str = KISDictionaryHaveKey(dic, @"content");
    
    CGSize size = [self labelAutoCalculateRectWith:str FontSize:14 MaxSize:CGSizeMake(KScreenWidth-80, 300)];
    
    height+=size.height;
    
    NSString *imgStr = KISDictionaryHaveKey(dic, @"photo");
    if (imgStr.length>0) {
    }else{
        height -= 200;
    }
    
    if ([KISDictionaryHaveKey(dic, @"zcount")intValue]>0) {
        height +=30;
        NSLog(@"有赞");
    }
    NSString *commStr =KISDictionaryHaveKey(dic, @"comment");
    if (commStr.length>0) {
        
        NSArray *arr = [NSArray array];
        arr = [self segmentationStrign:commStr withStr:@"#"];
        
        
        height+=20*arr.count;
        NSLog(@"有评论");
    }
    
    NSLog(@"height----%f---%f",height,size.height);
    return height;
}


#pragma mark-----CircleCell delegate ----did ZAN AND COMMENT

-(void)didClickZanWithCell:(CircleCell *)cell
{
    NSLog(@"点赞");
    cell.zanBtn.hidden = YES;
    cell.commBtn. hidden = YES;
    /*
     http://star.allappropriate.com/addcount?cid=3&zcount=102&uid=2696868409
     */
    NSDictionary *dic = [infoArray objectAtIndex:cell.tag];

    
    NSString *urlStr = [NSString stringWithFormat:@"addcount?cid=%@&zcount=%@&uid=%@",KISDictionaryHaveKey(dic, @"contentid"),KISDictionaryHaveKey(dic, @"zcount"),[[UserCache sharedInstance]objectForKey:KMYUSERID]];
    
    
    [[AFAppDotNetAPIClient sharedClient]POST:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"成功---%@",responseObject);
        
//        NSString *zanCount = KISDictionaryHaveKey(dic, @"zcount");
//        cell.zanBtn.countLabel.text = [NSString stringWithFormat:@"%d",[zanCount intValue]+1];

        [self getInfoFromNet];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"失败");
    }];
}
-(void)didClickCommWithCell:(CircleCell *)cell
{
    NSLog(@"点评论");
    
    cell.zanBtn.hidden = YES;
    cell.commBtn. hidden = YES;
    /*
     http://star.allappropriate.com/addcomment?uid=2696868409&cid=3&comment=好好好&nickname=大个头
     
     */
    
    NSDictionary *dic = [infoArray objectAtIndex:cell.tag];
    
    [commentDict removeAllObjects];
    
    commentDict  = [NSMutableDictionary dictionaryWithDictionary:dic];
    [commentBgView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goBackKeyBoard:)]];
    commentBgView.hidden = NO;
    [commentTF becomeFirstResponder];
}

#pragma mark ----textField DELEGATE
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *urlStr = [NSString stringWithFormat:@"addcomment?uid=%@&cid=%@&comment=%@&nickname=%@",KISDictionaryHaveKey(commentDict, @"uid"),KISDictionaryHaveKey(commentDict, @"contentid"),commentTF.text,KISDictionaryHaveKey([[UserCache sharedInstance]objectForKey:MYINFODICT], @"nickname")];
    
//    NSLog(@"评论列表-%@",commentDict);
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[AFAppDotNetAPIClient sharedClient]POST:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"成功---%@",responseObject);
        
        [self getInfoFromNet];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"失败");
    }];
    [commentTF resignFirstResponder];
    commentBgView.hidden = YES;
    [commentBgView removeGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goBackKeyBoard:)]];

    return YES;
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardadf:) name:UIKeyboardDidChangeFrameNotification object:nil];
}



-(void)keyboardadf:(NSNotification*)aNotification
{
    NSDictionary *info = [aNotification userInfo];
    CGSize kbSize =[[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    [self begainMoveUpAnimation:kbSize.height];
}

-(void)begainMoveUpAnimation:(float)heigth
{
    [UIView animateWithDuration:0.1 animations:^{
        commentView.frame =CGRectMake(0, KScreenHeight-(KISHighVersion_7?64:44)-55- heigth, KScreenWidth, 55);
    } completion:^(BOOL finished) {
    }];
}

-(void)goBackKeyBoard:(UITapGestureRecognizer *)tap
{
    [commentTF resignFirstResponder];
    commentView.frame = CGRectMake(0, KScreenHeight-(KISHighVersion_7?64:44), KScreenWidth, 55);
    [commentBgView removeGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goBackKeyBoard:)]];
    commentBgView.hidden = YES;
}

#pragma mark-----MDMenuviewcontroller delegate

-(NSString*)titleForChildControllerMDMenuViewController:(MDMenuViewController *)menuController
{
    return @"星友圈";
}
-(NSString*)iconForChildControllerMDMenuViewController:(MDMenuViewController *)menuController
{
    return @"xingyouquan.png";
}

-(void)enterNextPage:(UIButton *)sender
{
    SendCircleViewController *senderVC = [[SendCircleViewController alloc]init];
    [self.menuController pushViewController:senderVC withTransitionAnimator:[MDTransitionAnimatorFactory transitionAnimatorWithType:MDAnimationTypeSlideFromRight]];
//    [self.navigationController pushViewController:senderVC animated:YES];
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

//
//  XWViewController.m
//  Horoscope
//
//  Created by Satellite on 14/12/4.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import "XWViewController.h"
//#import "XingWenTableViewCell.h"

#import "AFAppDotNetAPIClient.h"

#import "UIImageView+AFNetworking.h"

#define KZFURL @"http://star.allappropriate.com/articlef"

@interface XWViewController ()

@end

@implementation XWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildTopviewWithBackButton:YES title:@"星文" rightImage:@"订阅－正常"];
    
    _tableView =[[UITableView alloc]init];

    _tableView.delegate =self;
    _tableView.dataSource =self;
    _tableView.frame =CGRectMake(0,startX, KScreenWidth, KScreenHeight -(KISHighVersion_7?64:44));
//  sx(<#m#>)
//    tableView.frame =self.view.bo;
    //解析
    [[AFAppDotNetAPIClient sharedClient] GET:@"article.php" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        


        _allArray = responseObject;
   
        
        [_tableView reloadData];

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    
        
    }];
    

    [self.view addSubview:_tableView];
    
//    [self buildTopviewWithBackButton:YES title:@"星文" rightImage:nil];
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic =_allArray[indexPath.row];

    UITextView *text = [[UITextView alloc]init];
    text.text = KISDictionaryHaveKey(dic, @"content");
    
    float f = [self getContenSizeAction:text];
    
    CGSize g = [self labelAutoCalculateRectWith:KISDictionaryHaveKey(dic, @"content") FontSize:14 MaxSize:CGSizeMake(KScreenWidth-28, 400)];
    
    return g.height+250+28+10+10;
//    return 600;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"CustomCellIdentifier";

    XWCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[XWCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic =_allArray[indexPath.row];
    
        cell.titleName.text = [dic valueForKey:@"title"] ;
        
//        [cell.facePic setImage:[UIImage imageNamed:@"touxiang1.png"]];
    cell.facePic.placeholderImage = KUIImage(@"touxiang1.png");
    cell.facePic.imageURL = nil;
    cell.newsPic.placeholderImage = KUIImage(@"touxiang1.png");
    cell.newsPic.imageURL =[NSURL URLWithString:KISDictionaryHaveKey(dic, @"photo")];
    NSLog(@"%@",cell.newsPic.imageURL);
    
        cell.newsText.text=[dic valueForKey:@"content"];
        cell.newsText.editable =NO;
        cell.newsTime.text =[dic valueForKey:@"crtime"];
    CGSize g = [self labelAutoCalculateRectWith:KISDictionaryHaveKey(dic, @"content") FontSize:14 MaxSize:CGSizeMake(KScreenWidth-28, 400)];
    
        cell.newsText.frame = CGRectMake(14, 60, KScreenWidth-28,g.height+10 );
        cell.newsPic.frame = CGRectMake(14, cell.newsText.frame.origin.y+cell.newsText.frame.size.height+10, KScreenWidth-28, 150);
    cell.share.frame = CGRectMake(KScreenWidth-96, sy(cell.newsPic)+10, 82, 28);
    cell.newsPic.backgroundColor = [UIColor grayColor];
        [cell.share setTitle:[@"  "stringByAppendingString:[_allArray[indexPath.row]valueForKey:@"count3"]] forState:UIControlStateNormal];
    cell.share.titleLabel.textAlignment = NSTextAlignmentRight;
    cell.share.titleLabel.textColor = [UIColor blackColor];
    [cell.share setBackgroundImage:KUIImage(@"xw_share") forState:UIControlStateNormal];

//        [cell.newsText sizeToFit];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*)titleForChildControllerMDMenuViewController:(MDMenuViewController *)menuController
{
    return @"星文";
}
-(NSString*)iconForChildControllerMDMenuViewController:(MDMenuViewController *)menuController
{
    return @"xingwen.png";
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)didClickShareWithCell:(XWCell*)cell
{
    UIActionSheet *shareSheet= [[UIActionSheet alloc]initWithTitle:@"分享" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"新浪微博" otherButtonTitles:@"QQ",@"微信好友",@"微信朋友圈", nil];
    shareSheet.tag = cell.tag;
    [shareSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSDictionary *dic = [_allArray objectAtIndex:actionSheet.tag];

    if (buttonIndex + 1 >= actionSheet.numberOfButtons ) {
        return;
    }
    NSArray *arr = [NSArray arrayWithObjects:@"sina",@"qq",@"wxsession",@"wxtimeline", nil];
    
    NSLog(@"%@",arr[buttonIndex]);
    //    [[UMSocialControllerService defaultControllerService] setShareText:shareText shareImage:shareImage socialUIDelegate:self];
    //    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:snsName];
    //    snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    
    NSString *titleStr = KISDictionaryHaveKey(dic, @"content");
    EGOImageView *imgView= [[ EGOImageView alloc]init];
    imgView.imageURL = [NSURL URLWithString:KISDictionaryHaveKey(dic, @"photo")];
    
    NSData * imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:KISDictionaryHaveKey(dic, @"photo")]];
    
    if (titleStr.length>128) {
        titleStr = [titleStr substringToIndex:128];
    }
    
    NSString *shareUrlStr =[@"http://star.allappropriate.com/articlef?aid="stringByAppendingString:KISDictionaryHaveKey(dic, @"aid")];
    
    [UMSocialQQHandler setQQWithAppId:SHAREQQID appKey:SHAREQQAPPKEY url:shareUrlStr];
    [UMSocialWechatHandler setWXAppId:SHAREWXID appSecret:SHAREWXAPPKEY url:shareUrlStr];
    
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[arr[buttonIndex]] content:titleStr image:imgData location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity * response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"成功" message:@"分享成功" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
            [alertView show];
        } else if(response.responseCode != UMSResponseCodeCancel) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"失败" message:@"分享失败" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
            [alertView show];
        }
    }];
    
    
    //    [UMSocialSnsService presentSnsIconSheetView:self
    //appKey:@"507fcab25270157b37000010"
    //shareText:@"你要分享的文字"
    //shareImage:[UIImage imageNamed:@"icon.png"]
    //shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,nil]
    //    delegate:self];
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

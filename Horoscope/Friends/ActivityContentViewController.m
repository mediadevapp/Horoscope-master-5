//
//  ActivityContentViewController.m
//  Horoscope
//
//  Created by Satellite on 15/1/28.
//
//

#import "ActivityContentViewController.h"
#import "EGOImageView.h"
@interface ActivityContentViewController ()

@end

@implementation ActivityContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTopViewWithTitle:KISDictionaryHaveKey(self.mainDic, @"title") withBackButton:YES];
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-60, KISHighVersion_7?20:0, 60, 44)];
    [button setImage:KUIImage(@"123123") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(enterNextPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    
    
    
    UILabel *titleLabel = [self buildLabelWithFrame:CGRectMake(20, startX+20, width(self.view)-40, 40) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] font:[UIFont boldSystemFontOfSize:24] textAlignment:NSTextAlignmentLeft text:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDic, @"title")]];
    [self.view addSubview:titleLabel];
    
    EGOImageView *headImg = [[EGOImageView alloc]initWithFrame:CGRectMake(10, 80+startX,width(self.view)-20, width(self.view)/2)];;
    
    headImg.imageURL = [NSURL URLWithString:KISDictionaryHaveKey(self.mainDic, @"photo")];
    [self.view addSubview:headImg];
    
    
    
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(10, startX+90+width(self.view)/2, width(self.view)-20, 400)];
    textView.scrollEnabled = YES;
    textView.editable = NO;
    textView.font = [UIFont systemFontOfSize:16];
    textView.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDic, @"content")];
    [self.view addSubview:textView];
    
    // Do any additional setup after loading the view.
}
-(void)getinfo
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [[AFAppDotNetAPIClient sharedClient]POST:@"" parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

-(void)enterNextPage:(id)sender
{
    
    UIActionSheet *shareSheet= [[UIActionSheet alloc]initWithTitle:@"分享" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"新浪微博" otherButtonTitles:@"QQ",@"微信好友",@"微信朋友圈", nil];
    [shareSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex + 1 >= actionSheet.numberOfButtons ) {
        return;
    }
    NSArray *arr = [NSArray arrayWithObjects:@"sina",@"qq",@"wxsession",@"wxtimeline", nil];
    NSString *titleStr = KISDictionaryHaveKey(self.mainDic, @"content");
    EGOImageView *imgView= [[ EGOImageView alloc]init];
    imgView.imageURL = [NSURL URLWithString:KISDictionaryHaveKey(self.mainDic, @"photo")];
    
    NSData * imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:KISDictionaryHaveKey(self.mainDic, @"photo")]];
    
    if (titleStr.length>128) {
        titleStr = [titleStr substringToIndex:128];
    }
    
    NSString *shareUrlStr =[@"http://star.allappropriate.com/articlef?eid="stringByAppendingString:KISDictionaryHaveKey(self.mainDic, @"eid")];
    
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

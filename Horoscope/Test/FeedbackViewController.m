//
//  FeedbackViewController.m
//  Horoscope
//
//  Created by Satellite on 14/12/18.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()
{
    UITextView *FBtextView;
}
@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTopViewWithTitle:@"反馈意见" withBackButton:YES];
    
    self.view.backgroundColor =[UIColor whiteColor];

    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-60, KISHighVersion_7?20:0, 60, 44)];
//    [button setImage:KUIImage(@"123123") forState:UIControlStateNormal];
    [button setTitle:@"发送" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(enterNextPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    
    FBtextView = [[UITextView alloc]initWithFrame:CGRectMake(5, KISHighVersion_7?74:54, KScreenWidth-10, KScreenWidth/2)];
    FBtextView.text = @"请输入您要反馈的问题";
    FBtextView.font = [UIFont systemFontOfSize:14];
    FBtextView.layer.borderColor = [[UIColor grayColor]CGColor];
    FBtextView.layer.borderWidth = 1;
    FBtextView.delegate = self;
    [self.view addSubview:FBtextView];
    
}



-(void)enterNextPage:(id)sender
{
    
    
    if (FBtextView.text!=nil&&![FBtextView.text isEqualToString:@""]&&![FBtextView.text isEqualToString:@" "]  &&FBtextView.text.length>0) {
        NSString *urlStr = [NSString stringWithFormat:@"feedback?nickname=%@&content=%@",[FBtextView.text stringByAppendingString:@"李昂是傻逼"],[[[UserCache sharedInstance]objectForKey:MYINFODICT]objectForKey:@"nickname"]];
        
        urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [[AFAppDotNetAPIClient sharedClient]POST:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            FBtextView.text  = @"";
            [self showAlertViewWithtitle:@"提示" message:@"反馈成功，我们会及时处理您的意见"];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [self showAlertViewWithtitle:@"提示" message:@"反馈失败 请检查网络"];
        }];

    }else{
        [self showAlertViewWithtitle:@"提示" message:@"请输入反馈内容"];
    }
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    FBtextView.text = @"";
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

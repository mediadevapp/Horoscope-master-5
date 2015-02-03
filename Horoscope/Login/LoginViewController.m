//
//  LoginViewController.m
//  Horoscope
//
//  Created by SAT on 14/12/11.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import "LoginViewController.h"
#import "signup1ViewController.h"
#import "NewMainViewController.h"
#import "UserCache.h"
#import "signup2ViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTopViewWithTitle:@"登录" withBackButton:NO];
    
    UIButton* backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, KISHighVersion_7 ? 20 : 0, 65, 44)];
    [backButton setImage:KUIImage(@"back") forState:UIControlStateNormal];
    [backButton setImage:KUIImage(@"back") forState:UIControlStateHighlighted];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];

    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth-60, KISHighVersion_7 ? 20 : 0, 60, 44)];
    [button setImage:KUIImage(@"wancheng.png") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(enterNextPage:) forControlEvents:UIControlEventTouchUpInside];
//    button.backgroundColor = [UIColor greenColor];
    [self.view bringSubviewToFront:button];
    [self.view addSubview:button];
    
    
    
    [_username setValue:[UIColor colorWithWhite:1 alpha:0.6] forKeyPath:@"_placeholderLabel.textColor"];
    _username.keyboardType = UIKeyboardTypeNumberPad;
    [_password setValue:[UIColor colorWithWhite:1 alpha:0.6] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)backButtonClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

-(void)enterNextPage:(UIButton *)btn
{
    
    if ([self isEmtity:_username.text]||[ self isEmtity:_password.text]) {
        
//        NSString * strafsdf =null;
        
       
            UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"错误" message:@"用户名和密码不能为空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
       
    
    }else{
        
        
        if (_username.text.length <11)
        {
            UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"错误" message:@"用户名不能小于11位！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
            
        }else if (![self isPureInt:_username.text]||![_username.text hasPrefix:@"1"])
        {
            UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"错误" message:@"请输入正确的手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        
        }else{
            NSString * loginStr =[NSString stringWithFormat:@"veruser?mobilenum=%@&password=%@",_username.text,_password.text];
            
            //        [NSString stringWithFormat:<#(NSString *), ...#>]
            
            [[AFAppDotNetAPIClient sharedClient] GET:loginStr parameters:nil success:^ (NSURLSessionDataTask *task, id responseObject) {
                
                            [[UserCache sharedInstance] setValue:loginStr forKey:@"userCode"];
                
//                            NSString * strsd =[[UserCache sharedInstance] objectForKey:@"userCode"];
			
//                NSString * state   =[NSString stringWithFormat:@"%@",responseObject];
                NSString * state   =KISDictionaryHaveKey(responseObject, @"id");

                [[UserCache sharedInstance] setValue:state forKey:@"userCode"];
                
//                [[UserCache sharedInstance] setValue:_username forKey:<#(NSString *)#>]
                
//                UIButton * btn =[UIButton buttonWithType:UIButtonTypeContactAdd];
//                btn setBackgroundImage:<#(UIImage *)#> forState:<#(UIControlState)#>
            
//                NSString * strsd =[[UserCache sharedInstance] objectForKey:@"userCode"];
                
                if (![state isEqualToString:@""]) {
                    if ([state  intValue]!=0) {
                        [[UserCache sharedInstance]setObject:state forKey:KMYUSERID];
                        [self getInfoFromNetWithUserid];
                        [self showMessageWindowWithContent:@"登录成功" imageType:0];
//                        [self.menuController popViewControllerAnimated:YES];
                        
                        [self dismissViewControllerAnimated:YES completion:^{
                            
                        }];
                        
                        
                        
                    }else{
                        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"错误" message:@"用户不存在，请选择注册或取消。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"注册", nil];
                        [alert show];
                    }
                }
                else{
                    UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"错误" message:@"用户不存在，请选择注册或取消。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"注册", nil];
                    [alert show];
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
            }];
        }
    }

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        signup2ViewController *signUp = [[signup2ViewController alloc]init];
        signUp.telNum = [NSMutableString stringWithString:_username.text];
//        [self.menuController pushViewController:signUp withTransitionAnimator:[MDTransitionAnimatorFactory transitionAnimatorWithType:MDAnimationTypeSlideFromRight]];
        [self.navigationController pushViewController:signUp animated:YES];
    }
}


-(NSString*)titleForChildControllerMDMenuViewController:(MDMenuViewController *)menuController
{
    return @"注册登录";
}
-(NSString*)iconForChildControllerMDMenuViewController:(MDMenuViewController *)menuController
{
    return @"xingwen.png";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    

    // Dispose of any resources that can be recreated.
}
- (IBAction)forgetPasswordAction:(id)sender {
}

-(void)getInfoFromNetWithUserid
{
    NSString * urlStr = [NSString stringWithFormat:@"userdetail.php?uid=%@",[[UserCache sharedInstance]objectForKey:KMYUSERID ]];
    [[AFAppDotNetAPIClient sharedClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
           NSDictionary * infoDict = [NSMutableDictionary dictionaryWithDictionary:responseObject];
            [[UserCache sharedInstance]setObject:infoDict forKey:MYINFODICT];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"LOIGNSUCCESS_WX_LIANGSHABI" object:nil];
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self showAlertViewWithtitle:@"提示" message:@"请求失败"];
    }];
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

//
//  signup3ViewController.m
//  Horoscope
//
//  Created by SAT on 15/1/9.
//
//

#import "signup3ViewController.h"
#import "signup4ViewController.h"

@interface signup3ViewController ()
{
    UIDatePicker *datePicker;
    NSString *sexStr;
}
@end

@implementation signup3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTopViewWithTitle:@"第三步" withBackButton:NO];
    
    UIButton* backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, KISHighVersion_7 ? 20 : 0, 65, 44)];
    [backButton setImage:KUIImage(@"back") forState:UIControlStateNormal];
    [backButton setImage:KUIImage(@"back") forState:UIControlStateHighlighted];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];

    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth-60, KISHighVersion_7?20:0, 60, 44)];
    [button setImage:KUIImage(@"wancheng.png") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(enterNextPage:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];

    
    self.nan.layer.masksToBounds = YES;
    self.nan.layer.cornerRadius = 13.0;
    self.nv.layer.masksToBounds = YES;
    self.nv.layer.cornerRadius = 13.0;
    
    
    //实例化UIDatePicker的视图
    datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0,KScreenHeight-200, KScreenWidth, 200)];
    
    //设置UIDatePicker 的样式
    datePicker.datePickerMode = UIDatePickerModeDate;
    [self.view bringSubviewToFront: datePicker];
    datePicker.backgroundColor = [UIColor colorWithWhite:0.8f alpha:0.5];
    [datePicker addTarget:self action:@selector(didClickDatePicker:) forControlEvents:UIControlEventValueChanged];
    //设置datepicker实例对象的tag
    datePicker.tag = 1001;
    [self.view addSubview:datePicker];

    [_nicheng setValue:[UIColor colorWithWhite:1 alpha:0.6] forKeyPath:@"_placeholderLabel.textColor"];
    
//    [_password setValue:[UIColor colorWithWhite:1 alpha:0.6] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    // Do any additional setup after loading the view from its nib.
    
    
    
    
}
-(void)backButtonClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)didClickDatePicker:(UIDatePicker*)date
{
    NSDateFormatter *formatter= [[NSDateFormatter alloc]init] ;
    //获取UIDatepicker对象
    [formatter setDateFormat:@"yyyy -MM -dd"];
    NSString * time = [formatter stringFromDate:datePicker.date];
    
    
    NSDateFormatter *formatter1= [[NSDateFormatter alloc]init] ;
    //获取UIDatepicker对象
    [formatter1 setDateFormat:@"MM"];
    NSString * time1 = [formatter1 stringFromDate:datePicker.date];

    NSDateFormatter *formatter2= [[NSDateFormatter alloc]init] ;
    //获取UIDatepicker对象
    [formatter2 setDateFormat:@"dd"];
    NSString * time2 = [formatter2 stringFromDate:datePicker.date];

    
    [self.pickViewButton setTitle:time forState:UIControlStateNormal];
    NSString *starStr = [self getAstroWithMonth:[time1 intValue] day:[time2 intValue]];
    
    
    [self.xingzuoButton setTitle:starStr forState:UIControlStateNormal];
    NSLog(@"%@",starStr);
}

-(NSString *)getAstroWithMonth:(int)m day:(int)d{
    
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    NSString *result;
    
    if (m<1||m>12||d<1||d>31){
        return @"错误日期格式!";
    }
    
    if(m==2 && d>29)
    {
        return @"错误日期格式!!";
    }else if(m==4 || m==6 || m==9 || m==11) {
        
        if (d>30) {
            return @"错误日期格式!!!";
        }
    }
    
    result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(m*2-(d < [[astroFormat substringWithRange:NSMakeRange((m-1), 1)] intValue] - (-19))*2,2)]];
    
    
    return result;
}


-(void)enterNextPage:(UIButton *)btn
{
    if (self.nicheng.text.length>10) {
        [self showAlertViewWithtitle:@"提示" message:@"昵称必须小于10字符"];
        return;
    }
    
    if ([self isEmtity:sexStr]) {
        [self showAlertViewWithtitle:@"提示" message:@"请选择性别"];
        return;
    }
    if ([self.xingzuoButton.titleLabel.text isEqualToString:@"您的星座"]) {
        [self showAlertViewWithtitle:@"提示" message:@"请选择年龄"];
        return;
    }
    if ([self isEmtity:self.nicheng.text]) {
        [self showAlertViewWithtitle:@"提示" message:@"请输入昵称"];
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.passWordStr forKey:@"password"];
    [dic setObject:self.telPhoneNumber forKey:@"mobilenum"];
    [dic setObject:self.nicheng.text forKey:@"nickname"];
    [dic setObject:@"111" forKey:@"phrase"];
    [dic setObject:sexStr forKey:@"sex"];
    [dic setObject:self.xingzuoButton.titleLabel.text forKey:@"xing"];
    [dic setObject:self.pickViewButton.titleLabel.text forKey:@"birthday"];
    
 [[AFAppDotNetAPIClient sharedClient]POST:@"userregistered" parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
     if ([responseObject isKindOfClass:[NSDictionary class]]) {
         NSString *uid =[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(responseObject, @"uid")];
         NSString *str= [@"123"stringByAppendingString:uid];
         [[UserCache sharedInstance]setObject:uid forKey:KMYUSERID];
         [self showAlertViewWithtitle:@"注册成功" message:str];
         [self getInfoFromNetWithUserid];
         [[NSNotificationCenter defaultCenter]postNotificationName:@"" object:nil];
         signup4ViewController * signStep4 =[[signup4ViewController alloc]init];
         [self.navigationController pushViewController:signStep4 animated:YES];
//         [self.menuController pushViewController:signStep4 withTransitionAnimator:[MDTransitionAnimatorFactory transitionAnimatorWithType:MDAnimationTypeSlideFromRight]];
     }
 } failure:^(NSURLSessionDataTask *task, NSError *error) {
     [self showAlertViewWithtitle:@"提示" message:@"注册失败"];
     [self dismissViewControllerAnimated:YES completion:^{
         
     }];
 }];
    
    
    
    
    
    

    
    
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

- (IBAction)didClickMan:(UIButton *)sender {
    self.nan.backgroundColor = [UIColor blueColor];
    self.nv.backgroundColor = [UIColor whiteColor];
    sexStr = @"男";
}

- (IBAction)didClickWoman:(UIButton *)sender {
    self.nan.backgroundColor = [UIColor whiteColor];
    self.nv.backgroundColor = [UIColor blueColor];
   sexStr = @"女";
}

- (IBAction)didClickDataPicker:(UIButton *)sender {
    [self.nicheng resignFirstResponder];
    datePicker.hidden = NO;
}
@end

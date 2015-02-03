//
//  PassWordChangeViewController.m
//  Horoscope
//
//  Created by Satellite on 15/1/22.
//
//

#import "PassWordChangeViewController.h"

@interface PassWordChangeViewController ()
{
    UITextField * oldPSTF;
    UITextField * newPSTF;
    UITextField * repeatPSTF;
}
@end

@implementation PassWordChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    [self setTopViewWithTitle:@"修改密码" withBackButton:YES];
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-60, KISHighVersion_7?20:0, 60, 44)];
    [button setImage:KUIImage(@"123123") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(senderChange:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    
    
    NSArray *ar = [NSArray arrayWithObjects:@"原始密码",@"新密码",@"重复密码", nil];
    for (int i = 0; i < 3; i++) {
        UILabel *lb = [self buildLabelWithFrame:CGRectMake(20, startX+40+i*50, 80, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] font:[UIFont boldSystemFontOfSize:17] textAlignment:NSTextAlignmentLeft text:ar[i]];
        [self.view addSubview:lb];
    }
    
    oldPSTF = [[UITextField alloc]initWithFrame:CGRectMake(120, startX+40, 200, 30)];
    oldPSTF.borderStyle =UITextBorderStyleRoundedRect;
    oldPSTF.textColor =[UIColor blackColor ];
    oldPSTF.clearButtonMode = UITextFieldViewModeAlways;
//    oldPSTF.secureTextEntry = YES;
    oldPSTF.textAlignment = NSTextAlignmentCenter;
    oldPSTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:oldPSTF];
    
    newPSTF = [[UITextField alloc]initWithFrame:CGRectMake(120, startX+90, 200, 30)];
    newPSTF.borderStyle =UITextBorderStyleRoundedRect;
    newPSTF.textColor =[UIColor blackColor ];
    newPSTF.clearButtonMode = UITextFieldViewModeAlways;
//    newPSTF.secureTextEntry = YES;
    newPSTF.textAlignment = NSTextAlignmentCenter;
    newPSTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:newPSTF];

    
    repeatPSTF = [[UITextField alloc]initWithFrame:CGRectMake(120, startX+140, 200, 30)];
    repeatPSTF.borderStyle =UITextBorderStyleRoundedRect;
    repeatPSTF.textColor =[UIColor blackColor ];
    repeatPSTF.clearButtonMode = UITextFieldViewModeAlways;
//    repeatPSTF.secureTextEntry = YES;
    repeatPSTF.textAlignment = NSTextAlignmentCenter;
    repeatPSTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:repeatPSTF];

}

-(void)senderChange:(id)sender
{
    [self.menuController popViewControllerAnimated:YES];
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

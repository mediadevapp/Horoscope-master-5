//
//  SingupViewController.m
//  Horoscope
//
//  Created by SAT on 15/1/9.
//
//

#import "SingupViewController.h"
#import "LoginViewController.h"
#import "signup1ViewController.h"
#import "signup4ViewController.h"
@interface SingupViewController ()

@end

@implementation SingupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isChildPage==YES) {
//        [self setti:YES title:@"您尚未登陆,请先登录"];
        [self setTopViewWithTitle:@"您尚未登录,请先登录" withBackButton:NO];
    }
    UIButton* backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, KISHighVersion_7 ? 20 : 0, 65, 44)];
    [backButton setImage:KUIImage(@"back") forState:UIControlStateNormal];
    [backButton setImage:KUIImage(@"back") forState:UIControlStateHighlighted];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];

    // Do any additional setup after loading the view from its nib.
}
-(void)backButtonClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)gotoMenu1:(UIButton  * )btn
{
     [self.menuController showMenu:self.menuController.topBar];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginAction:(id)sender{
    
    
    //登录

    LoginViewController * logVC =[[LoginViewController alloc]init];
    [self.navigationController pushViewController:logVC animated:YES];
//            [self.menuController pushViewController:logVC withTransitionAnimator:[MDTransitionAnimatorFactory transitionAnimatorWithType:MDAnimationTypeSlideFromRight]];    
}
- (IBAction)regeAction:(id)sender{
    
    
//    注册
    signup1ViewController * signUp1VC =[[signup1ViewController alloc]init];
//    signup4ViewController * signUp1VC =[[signup4ViewController alloc]init];
    [self.navigationController pushViewController:signUp1VC animated:YES];
//    [self.menuController pushViewController:signUp1VC withTransitionAnimator:[MDTransitionAnimatorFactory transitionAnimatorWithType:MDAnimationTypeSlideFromRight]];

    
    
}
-(NSString*)titleForChildControllerMDMenuViewController:(MDMenuViewController *)menuController
{
    return @"注册";
}
-(NSString*)iconForChildControllerMDMenuViewController:(MDMenuViewController *)menuController
{
    return @"xingwen.png";
}
-(void)buildTopviewWithBackButton:(BOOL)isHave title:(NSString *)title
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, KISHighVersion_7?64:44)];
    imageView.backgroundColor = [UIColor colorWithRed:0/225.0f green:0/225.0f blue:0/225.0f alpha:.5];
    imageView.image =[UIImage imageNamed:@""];
    imageView.userInteractionEnabled =  YES;
    [self.view bringSubviewToFront:imageView];
    [self.view addSubview:imageView];
    
    //    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(70, 20, self.view.bounds.size.width-140, 44)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(70, KISHighVersion_7?20:0, self.view.bounds.size.width-140, 44)];
    label.text = title;
    label.font = [UIFont boldSystemFontOfSize:22];
    label.textAlignment =NSTextAlignmentCenter;
    label.backgroundColor= [UIColor clearColor];
    
    label.textColor = [UIColor whiteColor];
    
    [imageView addSubview:label];
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, KISHighVersion_7?20:0, 60, 44)];
    [leftBtn setImage:[UIImage imageNamed:@"emnu.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(gotoMenu1:) forControlEvents:UIControlEventTouchUpInside];

    [imageView addSubview:leftBtn];
    
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

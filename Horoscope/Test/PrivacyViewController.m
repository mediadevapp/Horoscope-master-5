//
//  PrivacyViewController.m
//  Horoscope
//
//  Created by Satellite on 14/12/18.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import "PrivacyViewController.h"

@interface PrivacyViewController ()
{
    UITableView * myTableView;
    NSArray * titleArr1;
    NSArray * titleArr2;
    NSArray * titleArr3;
}
@end

@implementation PrivacyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"隐私" withBackButton:YES];
    
    self.view.backgroundColor =[UIColor whiteColor];

    myTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, KISHighVersion_7?64:44, KScreenWidth, KScreenHeight-(KISHighVersion_7?64:44)) style:UITableViewStylePlain];
    myTableView.bounces = NO;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    
    [self.view addSubview:myTableView];
    [self setExtraCellLineHidden:myTableView];

    titleArr1 = [NSArray arrayWithObjects:@"星友圈",@"不让他看我的朋友圈",@"不看他的朋友圈", nil];
        titleArr2 = [NSArray arrayWithObjects:@"通过ID可以搜索到我",@"关闭后，其他用户不能通过ID搜索到我",@"允许陌生人查看相册",@"私密资料",nil];
        titleArr3 = [NSArray arrayWithObjects:@"关闭后，不是相互关注的用户不能查看我的相册",@"向我推荐QQ好友",@"向我推荐微博好友",@"向我推荐微信好友", nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 4;
            break;
   
        default:
            return 4;
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = [titleArr1 objectAtIndex:indexPath.row];
            if (indexPath.row ==0) {
                cell.textLabel.textColor = [UIColor grayColor];
                cell.accessoryType = NO;
            }else{
                cell.textLabel.textColor = [UIColor blackColor];
                cell.accessoryType = YES;
            }
            break;
        case 1:
            cell.textLabel.text = [titleArr2 objectAtIndex:indexPath.row];
            if (indexPath.row ==1) {
                cell.textLabel.textColor = [UIColor grayColor];
                cell.accessoryType = NO;
            }else{
                cell.textLabel.textColor = [UIColor blackColor];
                cell.accessoryType = YES;
            }

            break;
  
        default:
            cell.textLabel.text = [titleArr3 objectAtIndex:indexPath.row];
            if (indexPath.row ==0) {
                cell.textLabel.textColor = [UIColor grayColor];
                cell.accessoryType = NO;
            }else{
                cell.textLabel.textColor = [UIColor blackColor];
                cell.accessoryType = YES;
            }

            break;
    }
    
    
//    cell.accessoryType = YES;
    return cell;
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

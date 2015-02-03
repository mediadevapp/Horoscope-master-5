//
//  DefaultMenuView.m
//  MDMenuViewController Demo
//
//  Created by Mohammed Eldehairy on 5/4/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import "DefaultMenuView.h"
#import "MineViewController.h"
#import "MDMenuViewController.h"
#import "SetUpViewController.h"
#import "SingupViewController.h"
@implementation DefaultMenuView
-(id)initWithFrame:(CGRect)frame
{
    self = [self initWithFrame:frame withMenuItems:[NSArray array]];
    return self;
}
- (id)initWithFrame:(CGRect)frame withMenuItems:(NSArray*)menuItems
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.8];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshHeadImg:) name:@"GETOUTLOIGN" object:nil];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshHeadImgSuccess:) name:@"LOIGNSUCCESS_WX_LIANGSHABI" object:nil];
        
        
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, self.bounds.size.width, self.bounds.size.height-10) style:UITableViewStylePlain];
        [self addSubview:tableView];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorColor = [UIColor clearColor];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.bounces = YES;
        tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        firstLoad = YES;
        tableView.rowHeight = 40;
        //添加headView;
        _headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, self.bounds.size.height/3+60)];
        
        
        _faceImageButton =[EGOImageButton buttonWithType:UIButtonTypeCustom];
        _faceImageButton.frame = CGRectMake(_headView.frame.origin.x/2+50, _headView.frame.origin.y+20, 85, 85) ;
        
        _faceImageButton.layer.masksToBounds = YES;
        _faceImageButton.layer.cornerRadius =85/2 ;

//        _faceImageButton.backgroundColor =[UIColor redColor];
        _faceImageButton.placeholderImage = KUIImage(@"placeholder.jpg");
        
        /*
         setBackgroundImage:[UIImage imageNamed:@"touxiang1.png"] forState:UIControlStateNormal];
         */
        
        [_faceImageButton addTarget:self action:@selector(faceChangeAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        

        
        
        _name=[[UILabel alloc]initWithFrame:CGRectMake(_faceImageButton.frame.origin.x, _faceImageButton.frame.origin.y +80, 100, 60)];
        _name.textAlignment = NSTextAlignmentCenter;
        _settingButton =[UIButton buttonWithType:UIButtonTypeCustom];
        _settingButton.frame =CGRectMake(10, _headView.frame.origin.y+20, 25, 25);
        
        [_settingButton setBackgroundImage:[UIImage imageNamed:@"shezhi.png"] forState:UIControlStateNormal];
//        [_settingButton addTarget:self action:@selector(settingChangeAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        if ([[UserCache sharedInstance]objectForKey:MYINFODICT]) {
            _name.text =KISDictionaryHaveKey([[UserCache sharedInstance]objectForKey:MYINFODICT], @"nickname");
            _faceImageButton.imageURL = [NSURL URLWithString:KISDictionaryHaveKey([[UserCache sharedInstance]objectForKey:MYINFODICT], @"photo")];
        }else{
            _name.text =@"未登录";
            _faceImageButton.imageURL = nil;
        }
        _name.textColor =[UIColor whiteColor];
        
//        [_settingButton setBackgroundColor:[UIColor whiteColor]];
        
        
         [_headView addSubview:_faceImageButton];
         [_headView addSubview:_name];
         [_headView addSubview:_settingButton];
        
        
        _headView.backgroundColor =[UIColor colorWithRed:(46.0f/255.0f) green:(46.0f/255.0f) blue:(46.0f/255.0f) alpha:1.0];
        tableView.tableHeaderView =_headView;
        
        
        MenuItems = [NSArray arrayWithArray:menuItems];
    }
    return self;
}

//添加方法 更换头像
- (void) faceChangeAction:(UIButton *)btn
{
    
    if ([[UserCache sharedInstance]objectForKey:KMYUSERID]) {
        MineViewController * mine =[[MineViewController alloc]init];
        mine.isRootView =YES;
        mine.userid =[NSString stringWithFormat:@"%@",[[UserCache sharedInstance]objectForKey:KMYUSERID]];
        [self.delegate pushViewController:mine animated:YES];

    }else{
        SingupViewController *sing =[[ SingupViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:sing];
        sing.isChildPage = YES;
//        [self.delegate pushViewController:sing animated:YES];
        [self.delegate presentViewController:nav animated:YES];
    }
//    [self.delegate pushViewController:mine withTransitionAnimator:[MDTransitionAnimatorFactory transitionAnimatorWithType:MDAnimationTypeSlideFromRight]];
    
//   [self.menuController pushViewController:mine withTransitionAnimator:[MDTransitionAnimatorFactory transitionAnimatorWithType:MDAnimationTypeSlideFromRight]];
}
//添加方法 个人设置
-(void)  settingChangeAction:(UIButton * )btn
{
    SetUpViewController * setUp =[[SetUpViewController alloc]init];
    
    
     [self.delegate pushViewController:setUp animated:YES];
    
}

-(void)setMenuItems:(NSArray *)menuItems
{
    MenuItems = menuItems;
    [tableView reloadData];
    
}
-(void)showMenuInView:(UIView *)containerView withRecommendedAnimationDuration:(NSTimeInterval)duration
{
    int menuOffset = 0;
    
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)
    {
        menuOffset = 200;
        
    }else
    {
        menuOffset = 400;
    }
    
    
    int y = 48;
    
    if(floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1 && [UIApplication sharedApplication].statusBarHidden == NO)
    {
        y = 68;
    }
    
    self.frame = CGRectMake(-self.frame.size.width, 0, menuOffset+24, containerView.bounds.size.height);
    
    [containerView addSubview:self];
    
    [UIView animateWithDuration:duration animations:^{
        
        
        
        
        
        
        
        CGRect menuRect = self.frame;
         
        menuRect.origin.x = 0;
        
         self.frame = menuRect;
        
        
    } completion:^(BOOL finished){
        
        
        
    }];

}






-(void)hideMenuFromView:(UIView *)containerView withRecommendedAnimationDuration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration animations:^{
        
        
        CGRect menuRect = self.frame;
        
        menuRect.origin.x = -self.bounds.size.width;
        
        self.frame = menuRect;
        
    } completion:^(BOOL finished){
        
        [self removeFromSuperview];
        
        
    }];
}
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    if(newSuperview)
    {
        
    }
}
-(void)didMoveToSuperview
{
    if(!self.superview)
    {
        return;
    }
    if(!firstLoad)
    {
        [tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.08];
    }else
    {
        firstLoad = NO;
    }
    
    
    
}

-(void)setSelectedMenuItem:(NSInteger)index
{
    [tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return MenuItems.count;
}
-(void)tableView:(UITableView *)tableView1 didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
    
    if (indexPath.row ==1||indexPath.row ==2||indexPath.row ==3) {
        if (![[UserCache sharedInstance]objectForKey:KMYUSERID]) {
            NSLog(@"你还没登陆！！！！");
            SingupViewController * setUp =[[SingupViewController alloc]init];
            setUp.isChildPage = YES;
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:setUp];

//            [self.delegate pushViewController:setUp animated:YES];
            [self.delegate presentViewController:nav animated:YES];
            return;
        }
    }
    
    MenuItemEntity *entity = [MenuItems objectAtIndex:indexPath.row];
    if([self.delegate respondsToSelector:@selector(MenuViewDidSelectMenuItem:atIndex:)])
    {
        [self.delegate MenuViewDidSelectMenuItem:entity.itemType atIndex:indexPath.row];
        
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"MenuItem";
    MenuViewCellView *cell = [tableView1 dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[MenuViewCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    MenuItemEntity *entity = [MenuItems objectAtIndex:indexPath.row];
    cell.titleLbl.text = entity.title;
    cell.titleLbl.textColor = menuItemTitleTextColorNormal ? menuItemTitleTextColorNormal : [UIColor whiteColor];
    cell.titleLbl.textAlignment = NSTextAlignmentLeft;
    cell.titleLbl.font = [UIFont systemFontOfSize:18];
    cell.backgroundColor = menuItemBackgroundColorNormal ? menuItemBackgroundColorNormal : [UIColor clearColor];
    cell.delegate = self;
    cell.backImageView.image = menuItemBackgroundImageNormal;
    
    if(entity.iconName && ![entity.iconName isEqualToString:@""])
        cell.iconView.image = [UIImage imageNamed:entity.iconName];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)tableView:(UITableView *)tableView1 willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.disableRippleAnimation)
    {
        return;
    }
    
    cell.alpha = 1.0;
    CATransform3D scale = CATransform3DMakeTranslation(tableView1.bounds.size.width, 0, 0);
    cell.layer.transform = CATransform3DConcat(scale, CATransform3DMakeScale(0.1, 0.1, 0.1));
    
    [UIView animateWithDuration:0.18 delay:indexPath.row*0.06 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        
        cell.alpha = 1.0;
       // cell.layer.transform = CATransform3DMakeTranslation(-7, 0, 0);
        cell.layer.transform = CATransform3DConcat(CATransform3DMakeTranslation(-7, 0, 0), CATransform3DMakeScale(1.3, 1.3, 1.3));
        
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.13 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
             cell.layer.transform = CATransform3DConcat(CATransform3DMakeTranslation(5, 0, 0), CATransform3DMakeScale(0.9, 0.9, 0.9)) ;
            
        } completion:^(BOOL finished){
            
            
            [UIView animateWithDuration:0.09 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                cell.layer.transform = CATransform3DIdentity;
                
                
            } completion:^(BOOL finished){
                
            }];
            
        }];
    }];
}
-(void)cellView:(MenuViewCellView *)cellView Selected:(BOOL)selected
{
    if(selected)
    {
        if(menuItemTitleTextColorHighlighted)
            cellView.titleLbl.textColor = menuItemTitleTextColorHighlighted;
        
        if(menuItemBackgroundImageHighlighted)
            cellView.backImageView.image = menuItemBackgroundImageHighlighted;
        
        if(menuItemBackgroundColorHighlighted)
            cellView.backgroundColor = menuItemBackgroundColorHighlighted;
        
    }else
    {
        if(menuItemTitleTextColorNormal)
            cellView.titleLbl.textColor = menuItemTitleTextColorNormal ;
        
        if(menuItemBackgroundImageNormal)
            cellView.backImageView.image = menuItemBackgroundImageNormal;
        
        if(menuItemBackgroundColorNormal)
            cellView.backgroundColor = menuItemBackgroundColorNormal;
        
    }
}
-(void)setMenuItemTitleTextColor:(UIColor *)txtColor forState:(UIControlState)controlState
{
    if(controlState == UIControlStateNormal)
    {
        menuItemTitleTextColorNormal = txtColor;
    }else if (controlState == UIControlStateHighlighted)
    {
        menuItemTitleTextColorHighlighted = txtColor;
    }
}
-(void)setMenuItemBackgroundColor:(UIColor*)backColor forState:(UIControlState)controlState
{
    if(controlState == UIControlStateNormal)
    {
        menuItemBackgroundColorNormal = backColor;
    }else if (controlState == UIControlStateHighlighted)
    {
        menuItemBackgroundColorHighlighted = backColor;
    }
}
-(void)setMenuItemBackgroundImage:(UIImage*)backImage forState:(UIControlState)controlState
{
    if(controlState == UIControlStateNormal)
    {
        menuItemBackgroundImageNormal = backImage;
    }else if (controlState == UIControlStateHighlighted)
    {
        menuItemBackgroundImageHighlighted = backImage;
    }
}

-(void)refreshHeadImg:(NSNotification *)info
{
    _faceImageButton.imageURL = nil;
    _name.text = @"未登录";
}
-(void)refreshHeadImgSuccess:(id)sender
{
    _faceImageButton.imageURL = [NSURL URLWithString:[[[UserCache sharedInstance]objectForKey:MYINFODICT]objectForKey:@"photo"]];
    _name.text =[[[UserCache sharedInstance]objectForKey:MYINFODICT]objectForKey:@"nickname"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

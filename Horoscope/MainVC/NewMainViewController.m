//
//  NewMainViewController.m
//  Horoscope
//
//  Created by Satellite on 14/12/2.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import "NewMainViewController.h"
#import "MainCollectionViewCell.h"
#import "AddButton.h"
#import "MineViewController.h"
@interface NewMainViewController ()
{
    UICollectionView * m_CollView;
    UICollectionViewFlowLayout * m_layout;
    UIImageView * blackImageView;
    AddButton * ccButton;
    NSMutableArray *infoArray;
    NSMutableArray *arr1;
    TopView *topView;
    NSMutableArray *allArr;
    
    
    MJRefreshHeaderView *m_header;

}
@end

@implementation NewMainViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didClickNotification:) name:@"didClick_wx_drx" object:nil];
    
    [self buildTopviewWithBackButton:NO title:@"星座达人秀 - TOP" rightImage:@""];
    
    m_layout = [[UICollectionViewFlowLayout alloc]init];
    [m_layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    m_layout.minimumLineSpacing = 3;
    m_layout.minimumInteritemSpacing = 2;
    m_CollView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, width(self.view), height(self.view)-64) collectionViewLayout:m_layout];
   
    [m_CollView registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewCell1"];
    
    topView = [[TopView alloc]init];
    [m_CollView registerClass:[TopView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headViewww"];

    //设置代理
    m_layout.itemSize = CGSizeMake(width(self.view)/3-2, width(self.view)/3+15);
    m_CollView.delegate = self;
    m_CollView.dataSource = self;
    
    [self.view addSubview:m_CollView];
    [self buildBlackView];
    
    infoArray = [NSMutableArray array];
    arr1 = [NSMutableArray array];
    allArr = [NSMutableArray array];
    [self getInfoFromNet];
    [self addHeader];

}

-(void)getInfoFromNet
{
    [[AFAppDotNetAPIClient sharedClient] GET:@"userlist.php" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"1");
        }else if([responseObject isKindOfClass:[NSArray class]]){
            [allArr removeAllObjects];
            [allArr addObjectsFromArray:responseObject];
            
            [arr1 removeAllObjects];
            [infoArray removeAllObjects];
            for (int i = 0; i<allArr.count; i++) {
                NSDictionary *dic = [allArr objectAtIndex:i];
                if (i<6) {
                    [arr1 addObject:dic];
                }else{
                    [infoArray addObject:dic];
                }
            }
            [m_header endRefreshing];
            [m_CollView reloadData];
        }else{
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [m_header endRefreshing];
        [self showAlertViewWithtitle:@"提示" message:@"好友列表请求失败"];
    }];
}



#pragma mark---collectionViewDELEGATE


//设置分区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个分区上的元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return infoArray.count;
}

//设置元素内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *identify = @"cell";
    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell1" forIndexPath:indexPath];
//    [cell sizeToFit];
    if (!cell) {
//        cell = [[MainCollectionViewCell alloc]init];
    }
    
    NSDictionary *dic = [infoArray objectAtIndex:indexPath.row];
    
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 6.0;
    cell.layer.borderWidth = 1.0;
    cell.layer.borderColor = [[UIColor blackColor] CGColor];
    cell.numLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+7];
    cell.leftImageView.image = KUIImage(@"排名色块小");
    cell.MainImageView.imageURL = [NSURL URLWithString:[dic objectForKey:@"photo"]];
    cell.nameLabel.text = [dic objectForKey:@"nickname"];
    NSLog(@"%@",cell);
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    TopView *titleView;
    
    if (kind == UICollectionElementKindSectionHeader) {
        titleView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headViewww" forIndexPath:indexPath];
        if (arr1.count==6) {
            titleView.hidden = NO;
            titleView.cell1.MainImageView.imageURL = [NSURL URLWithString:[[arr1 objectAtIndex:1] objectForKey:@"photo"]];
            titleView.cell1.nameLabel.text = [[arr1 objectAtIndex:1] objectForKey:@"nickname"];
            
            titleView.cell2.MainImageView.imageURL = [NSURL URLWithString:[[arr1 objectAtIndex:2] objectForKey:@"photo"]];
            titleView.cell2.nameLabel.text = [[arr1 objectAtIndex:2] objectForKey:@"nickname"];
            
            titleView.cell3.MainImageView.imageURL = [NSURL URLWithString:[[arr1 objectAtIndex:3] objectForKey:@"photo"]];
            titleView.cell3.nameLabel.text = [[arr1 objectAtIndex:3] objectForKey:@"nickname"];
            titleView.cell4.MainImageView.imageURL = [NSURL URLWithString:[[arr1 objectAtIndex:4] objectForKey:@"photo"]];
            titleView.cell4.nameLabel.text = [[arr1 objectAtIndex:4] objectForKey:@"nickname"];
            
            titleView.cell5.MainImageView.imageURL = [NSURL URLWithString:[[arr1 objectAtIndex:5] objectForKey:@"photo"]];
            titleView.cell5.nameLabel.text = [[arr1 objectAtIndex:5] objectForKey:@"nickname"];
            
            titleView.cell6.MainImageView.imageURL = [NSURL URLWithString:[[arr1 objectAtIndex:0] objectForKey:@"photo"]];
            titleView.cell6.nameLabel.text = [[arr1 objectAtIndex:0] objectForKey:@"nickname"];
        }else{
            titleView.hidden = YES;
        }

        }
        
    return titleView;
}
-(void)didClickNotification:(NSNotification*)sender
{
    [self customViewDidClick:[[sender.userInfo objectForKey:@"tag"] intValue]];
}


//设置元素的的大小框
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets top = {0,0,0,0};//{5,5,5,5};
    return top;
}

//设置顶部的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={width(self.view),width(self.view)+55};
    return size;
}
//设置元素大小
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
////    if (indexPath.row==0) {
////        return CGSizeMake(width(self.view)/3*2-10, width(self.view)/3*2-10);
////    }
//    
//    return CGSizeMake(width(self.view)/3, width(self.view)/3+10 );
//}


-(void)customViewDidClick:(int)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        ccButton.frame =CGRectMake(0, 400, 307, 72);
        
    } completion:^(BOOL finished) {
    }];
    ccButton.tag = sender;
    
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[arr1 objectAtIndex:ccButton.tag]];
    
    blackImageView.hidden = NO;
    ccButton.hidden = NO;
    ccButton.constellationLab.text = KISDictionaryHaveKey(dic, @"xing");
    ccButton.constellationImg.image = KUIImage([self GetNameReturnImageWithName:KISDictionaryHaveKey(dic, @"xing")]);
    ccButton.nameLab.text = [NSString stringWithFormat:@"昵称:%@",KISDictionaryHaveKey(dic,@"nickname")];
    ccButton.lineLab.text = KISDictionaryHaveKey(dic, @"phrase");
    // 透明界面出现  添加点击手势
    [blackImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didHiddenBlView:)]];

}



//点击元素触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor yellowColor];
    [UIView animateWithDuration:0.5 animations:^{
        ccButton.frame =CGRectMake(0, 400, 307, 72);
        
    } completion:^(BOOL finished) {
    }];
    
    NSDictionary *dic = infoArray[indexPath.row];
    
    
    ccButton.tag = indexPath.row+6;
    
    blackImageView.hidden = NO;
    ccButton.hidden = NO;
    ccButton.constellationLab.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"xing")];
    ccButton.constellationImg.image = KUIImage([self GetNameReturnImageWithName:KISDictionaryHaveKey(dic, @"xing")]);
    ccButton.nameLab.text = [NSString stringWithFormat:@"昵称:%@",KISDictionaryHaveKey(dic,@"nickname")];
    ccButton.lineLab.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"phrase")];
    // 透明界面出现  添加点击手势
    [blackImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didHiddenBlView:)]];

}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)buildBlackView
{
    blackImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height)];
    blackImageView.image = [UIImage imageNamed:@"blackView"];
    blackImageView.hidden = YES;
    blackImageView.userInteractionEnabled = YES;
    [self.view addSubview:blackImageView];
    
    ccButton = [[AddButton alloc]initWithFrame:CGRectMake(-307, 400, 307, 72)];
        
    //    ccButton.backgroundColor = [UIColor clearColor];
//    [ccButton setImage:[UIImage imageNamed:@"btimg"] forState:UIControlStateNormal];
    [ccButton addTarget:self action:@selector(didClickTap:) forControlEvents:UIControlEventTouchUpInside];
    ccButton.hidden = YES;
    [blackImageView addSubview:ccButton];
}


//点击显示菜单栏

-(void)didClickTap:(UIButton *)sender
{
    NSLog(@"%ld",(long)ccButton.tag);
    MineViewController *mineView = [[MineViewController alloc]init];
    mineView.isRootView = NO;
    NSDictionary *dic =[allArr objectAtIndex:sender.tag];
    mineView.userid =KISDictionaryHaveKey(dic, @"uid");
    [self.menuController pushViewController:mineView withTransitionAnimator:[MDTransitionAnimatorFactory transitionAnimatorWithType:MDAnimationTypeSlideFromRight]];
    [self didHiddenBlView:nil];
}

//点击隐藏遮罩层 显示主页面
-(void)didHiddenBlView:(UIGestureRecognizer*)sender
{
    
    [UIView animateWithDuration:0.5 animations:^{
        ccButton.frame =CGRectMake(-307, 400, 307, 72);
        
    } completion:^(BOOL finished) {
    }];
    blackImageView.hidden = YES;
    ccButton.hidden = YES;
    //透明遮罩隐藏 remove手势
    [blackImageView removeGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didHiddenBlView:)]];
    
}

-(void)didClickButton:(NSInteger)n
{
    MineViewController *mine = [[MineViewController alloc]init];
    mine.isRootView = NO;
     [self.menuController pushViewController:mine withTransitionAnimator:[MDTransitionAnimatorFactory transitionAnimatorWithType:MDAnimationTypeSlideFromRight]];
    
    [self didHiddenBlView:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSString*)titleForChildControllerMDMenuViewController:(MDMenuViewController *)menuController
{
    return @"星座达人";
}
-(NSString*)iconForChildControllerMDMenuViewController:(MDMenuViewController *)menuController
{
    return @"darenxiu.png";
}


- (void)addHeader
{
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    CGRect headerRect = header.arrowImage.frame;
    headerRect.size = CGSizeMake(30, 30);
    header.arrowImage.frame = headerRect;
    header.activityView.center = header.arrowImage.center;
    header.scrollView = m_CollView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        [self getInfoFromNet];
    };
    m_header = header;
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

//
//  testViewController.m
//  Horoscope
//
//  Created by SAT on 14/12/29.
//
//

#import "SexttestViewController.h"
#import "AFAppDotNetAPIClient.h"
#import "testTableViewCell.h"
#import "UIImageView+AFNetworking.h"

#import "testDetailedViewController.h"

#import "ExampleViewController.h"

#import "CustHeadView.h"

#import <QuartzCore/QuartzCore.h>

#define imageHeight ImageHeight = 280;


@interface SexttestViewController ()

@end

@implementation SexttestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildTopviewWithBackButton:YES title:@"测试" rightImage:@"订阅－正常.png"];
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"CustHeadView" owner:nil options:nil];
    
    
    self.view.backgroundColor = [UIColor blackColor];
    
    _custHeadView =   [nibView objectAtIndex:0];
    [_custHeadView setFrame:CGRectMake(0, 0, KScreenWidth,280)];
    [self.view addSubview:_custHeadView];
    
    
    _custHeadView.backgroundColor = [UIColor lightGrayColor];
    imageHeight
//    CGSize imagesSize = CGSizeMake(_custHeadView.frame.size.width, _custHeadView.frame.size.height);
    
//    UIImage *image1 = [[UIImage imageNamed:@"lunbo1.jpg"]imageByScalingToSize:imagesSize];
//    UIImage *image2 = [[UIImage imageNamed:@"lunbo2.jpg"]imageByScalingToSize:imagesSize];
//    UIImage *image3 = [[UIImage imageNamed:@"lunbo3.jpg"]imageByScalingToSize:imagesSize];
//    UIImage *image4 = [[UIImage imageNamed:@"lunbo4.jpg"]imageByScalingToSize:imagesSize];
    
    
    UIImage *image1 = [UIImage imageNamed:@"lunbo1.jpg"];
    UIImage *image2 = [UIImage imageNamed:@"lunbo2.jpg"];
    UIImage *image3 = [UIImage imageNamed:@"lunbo3.jpg"];
    UIImage *image4 = [UIImage imageNamed:@"lunbo4.jpg"];
    
    
    self.arrayImages = [NSArray arrayWithObjects:image1,image2,image3,image4, nil];
    
    [_custHeadView.mailScorllView setPagingEnabled:YES];
    _custHeadView.mailScorllView.showsHorizontalScrollIndicator = NO;
    _custHeadView.mailScorllView.showsVerticalScrollIndicator = NO;
    [_custHeadView.mailScorllView setDelegate:self];
    
    //ContentSize 这个属性对于UIScrollView－关键－，取决于是否滚动。
    [_custHeadView.mailScorllView setContentSize:CGSizeMake(KScreenWidth * [self.arrayImages count], ImageHeight)];
    
    
    _custHeadView.pageControls.currentPage = 0;
    _custHeadView.pageControls.numberOfPages = [self.arrayImages count];
    [_custHeadView.pageControls addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
    
    _viewController = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < [self.arrayImages count]; i++) {
        [_viewController addObject:[NSNull null]];
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(scrollPages) userInfo:nil repeats:YES];
    
    [self loadScrollViewPage:0];
    [self loadScrollViewPage:1];
    [self loadScrollViewPage:2];
    [self loadScrollViewPage:3];
    
    
    _testTableView.delegate =self;
    _testTableView.dataSource =self;
    _testTableView.tableHeaderView =_custHeadView;
    
    //请求数据
    [[AFAppDotNetAPIClient sharedClient] GET:@"testlist.php" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        _allArray = responseObject;
        [_testTableView reloadData];
        [self custView];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
}



#pragma mark ---轮播方法实现---
//加载滚动视图页
-(void)loadScrollViewPage:(NSInteger)page
{
    if (page >= self.arrayImages.count) {
        return;
    }
    
    UIViewController *imageViewController = [self.viewController objectAtIndex:page];
    if ((NSNull *)imageViewController == [NSNull null])
    {
        imageViewController = [[UIViewController alloc] init];
        [self.viewController replaceObjectAtIndex:page withObject:imageViewController];
    }
    
    if (imageViewController.view.superview == nil) {
        CGRect frame = _custHeadView.mailScorllView.frame;
        frame.origin.x = KScreenWidth * page;
        frame.origin.y = 0;
        imageViewController.view.frame = frame;
        
        [self addChildViewController:imageViewController];
        [_custHeadView.mailScorllView addSubview:imageViewController.view];
        [imageViewController didMoveToParentViewController:self];
        
        [imageViewController.view setBackgroundColor:[UIColor colorWithPatternImage:(UIImage *)[self.arrayImages objectAtIndex:page]]];
    }
}
//滚动视图并减速
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = KScreenWidth;
    NSInteger page = floor((_custHeadView.mailScorllView.contentOffset.x -pageWidth/2)/pageWidth) +1;
    _custHeadView.pageControls.currentPage = page;
    
    [self loadScrollViewPage:page-1];
    [self loadScrollViewPage:page];
    [self loadScrollViewPage:page+1];
}

//改变页
- (void)changePage:(id)sender
{
    NSInteger page = _custHeadView.pageControls.currentPage;
    
    [self loadScrollViewPage:page - 1];
    [self loadScrollViewPage:page];
    [self loadScrollViewPage:page + 1];
    
    CGRect bounds = _custHeadView.mailScorllView.bounds;
    bounds.origin.x = CGRectGetWidth(bounds) * page;
    bounds.origin.y = 0;
    [_custHeadView.mailScorllView scrollRectToVisible:bounds animated:YES];
}

//滚动页
-(void)scrollPages{
    ++_custHeadView.pageControls.currentPage;
    CGFloat pageWidth = CGRectGetWidth(_custHeadView.mailScorllView.frame);
    if (isFromStart) {
        [_custHeadView.mailScorllView setContentOffset:CGPointMake(0, 0) animated:YES];
        _custHeadView.pageControls.currentPage = 0;
    }
    else
    {
        [_custHeadView.mailScorllView setContentOffset:CGPointMake(pageWidth*_custHeadView.pageControls.currentPage, _custHeadView.mailScorllView.bounds.origin.y)];
        
    }
    if (_custHeadView.pageControls.currentPage == _custHeadView.pageControls.numberOfPages - 1) {
        isFromStart = YES;
    }
    else
    {
        isFromStart = NO;
    }
}




-(void)custView
{
    
    

    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 83;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    
    return _allArray.count;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CustomCellIdentifier = @"CustomCellIdentifier";
    
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"testTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CustomCellIdentifier];
        nibsRegistered = YES;
    }
    
    testTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    
    
    if (_allArray.count <1) {
        
    }else{
        
        [cell.titleLable setText:[_allArray[indexPath.row]valueForKey:@"title"]];
        
        
        [cell.facePIc setImageWithURL:[NSURL URLWithString:[_allArray[indexPath.row]valueForKey:@"pics"]]placeholderImage:[UIImage imageNamed:@"touxiang1.png"]];
        cell.facePIc.layer.cornerRadius = 6;
        cell.facePIc.layer.masksToBounds = YES;
        //        [cell.facePIc.layer setBorderWidth:2];
        cell.howPolple.text=@"111人";
        cell.timeLable.text =@"1小时前";
        
        
    }
    
    
    
    return cell;
}




-(NSString*)titleForChildControllerMDMenuViewController:(MDMenuViewController *)menuController
{
    return @"测试";
}
-(NSString*)iconForChildControllerMDMenuViewController:(MDMenuViewController *)menuController
{
    return @"ceshi.png";
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    ExampleViewController * exampleVC =[[ExampleViewController alloc]init];
    
    
    exampleVC.exampleDic = [NSMutableDictionary dictionary];
    
    exampleVC.exampleDic =[_allArray objectAtIndex:indexPath.row];
    
    
    [self.menuController pushViewController:exampleVC withTransitionAnimator:[MDTransitionAnimatorFactory transitionAnimatorWithType:MDAnimationTypeSlideFromRight]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end


#pragma mark ---扩展---
//扩展UIImage类的方法实现（改变image的大小）
@implementation UIImage (UIImageExtras)

//- (UIImage *)imageByScalingToSize:(CGSize)targetSize
//
//{

//    UIImage *sourceImage = self;
//    
//    UIImage *newImage = nil;
//    
//    CGSize imageSize = sourceImage.size;
//    
//    CGFloat width = imageSize.width;
//    
//    CGFloat height = imageSize.height;
//    
//    CGFloat targetWidth = targetSize.width;
//    
//    CGFloat targetHeight = targetSize.height;
//    
//    CGFloat scaleFactor = 0.0;
//    
//    CGFloat scaledWidth = targetWidth;
//    
//    CGFloat scaledHeight = targetHeight;
//    
//    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
//    
//    if (CGSizeEqualToSize(imageSize, targetSize) ==NO) {
//        
//        CGFloat widthFactor = targetWidth / width;
//        
//        CGFloat heightFactor = targetHeight / height;
//        
//        if (widthFactor < heightFactor)
//            
//            scaleFactor = widthFactor;
//        
//        else
//            
//            scaleFactor = heightFactor;
//        
//        scaledWidth  = width * scaleFactor;
//        
//        scaledHeight = height * scaleFactor;
//        
//        // center the image
//        
//        if (widthFactor < heightFactor) {
//            
//            
//            
//            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
//            
//        } else if (widthFactor > heightFactor) {
//            
//            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
//            
//        }
//        
//    }
//    
//    // this is actually the interesting part:
//    
//    UIGraphicsBeginImageContext(targetSize);
//    
//    CGRect thumbnailRect = CGRectZero;
//    
//    thumbnailRect.origin = thumbnailPoint;
//    
//    thumbnailRect.size.width  = scaledWidth;
//    
//    thumbnailRect.size.height = scaledHeight;
//    
//    [sourceImage drawInRect:thumbnailRect];
//    
//    newImage =UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    if(newImage == nil)
//    {
//        
//        //        NSLog(@"－－－－－－－－－－－－－－could not scale image");
//    }
//    return newImage ;
    
    
//}


@end

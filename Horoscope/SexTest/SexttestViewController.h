//
//  testViewController.h
//  Horoscope
//
//  Created by SAT on 14/12/29.
//
//

#import "BaseViewController.h"
#import "CustHeadView.h"
//扩展UIImage类的
//@interface UIImage (UIImageExtras)
//
//- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
//
//@end

@interface SexttestViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{


    BOOL isFromStart;
    NSInteger ImageHeight;
}

@property (nonatomic,strong)NSArray * allArray;

@property (weak, nonatomic) IBOutlet UITableView *testTableView;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UIView *headView;

@property (weak, nonatomic) IBOutlet UIPageControl *testPageControler;
@property (weak, nonatomic) IBOutlet UIScrollView *topSrcollView;



//轮播
@property (nonatomic,strong) CustHeadView *custHeadView;
@property(nonatomic, strong)NSArray  *arrayImages;          //存放图片的数组
@property(nonatomic, strong)NSMutableArray *viewController; //存放UIViewController的可变数组

@property (nonatomic) NSTimer *timer;


@end

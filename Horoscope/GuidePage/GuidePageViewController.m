//
//  GuidePageViewController.m
//  Horoscope
//
//  Created by Satellite on 14/12/29.
//
//

#import "GuidePageViewController.h"

@interface GuidePageViewController ()
{
    AppDelegate *app;
    UIPageControl * myPageControl;
}
@end

@implementation GuidePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIScrollView *scr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    scr.pagingEnabled = YES;
    scr.delegate = self;
    scr.contentSize = CGSizeMake(KScreenWidth*3, 0);
    scr.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scr];
    
    
    NSMutableArray *imgArr = [NSMutableArray array];
    
    float height = KScreenHeight;
    
    if (height ==667) {
        [imgArr removeAllObjects];
        [imgArr addObject:@"1-6"];
        [imgArr addObject:@"2-6"];
        [imgArr addObject:@"3-6"];
    }else if (height ==736)
    {
        [imgArr removeAllObjects];
        [imgArr addObject:@"1"];
        [imgArr addObject:@"2"];
        [imgArr addObject:@"3"];
        
    }else if (height ==568)
    {
        [imgArr removeAllObjects];
        [imgArr addObject:@"1-568h"];
        [imgArr addObject:@"2-568h"];
        [imgArr addObject:@"3-568h"];

    }else if(height ==480)
    {
        [imgArr removeAllObjects];
        [imgArr addObject:@"1-4"];
        [imgArr addObject:@"2-4"];
        [imgArr addObject:@"3-4"];

    }
    
    /*
     6---667
     6p   736
     5    568
     4   480
     */
    
    for (int i = 0; i<3; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth*i, 0, KScreenWidth, KScreenHeight)];
        imageView.image = KUIImage(imgArr[i]);
        [scr addSubview:imageView];
    }
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth/5*2, KScreenWidth/5*2*0.26)];
    button.center = CGPointMake(KScreenWidth*2.5, KScreenHeight*.7+30);
    [button setBackgroundImage:KUIImage(@"start-normal") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didChangeRootViewController:) forControlEvents:UIControlEventTouchUpInside];
    [scr addSubview:button];
    
    NSLog(@"%f",KScreenWidth);
    myPageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, y(button)+50, self.view.bounds.size.width, 30)];
    myPageControl.backgroundColor = [UIColor clearColor];
    myPageControl.numberOfPages = 3;
    myPageControl.currentPage = 0;
    myPageControl.pageIndicatorTintColor = [UIColor grayColor];
    myPageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    [self.view addSubview:myPageControl];
    
    
    // Do any additional setup after loading the view.
}
-(void)didChangeRootViewController:(UIButton *)sender
{
    app.window.rootViewController = app.mainViewC;
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = sender.frame.size.width;
    int page = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    myPageControl.currentPage = page;
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

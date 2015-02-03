//
//  MBButtonShowView.m
//  BOCMBCI
//
//  Created by SAT on 14/12/31.
//  Copyright (c) 2014年 China M-World Co.,Ltd. All rights reserved.
//

#import "MBButtonShowView.h"

@implementation MBButtonShowView

- (id)initWithFrame:(CGRect)frame showImage:(UIImage *)imageView Title:(NSString *)title WithTarget:(UIViewController *)selfVC
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        
          _backgroudView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 590)];
        _imageViewForShow =[[UIImage alloc]init];
        _imageViewForShow= imageView;
        _selfVC= selfVC;
        _backgroudView.backgroundColor =[UIColor clearColor];
        
        UILabel * mylabel =[[UILabel alloc]initWithFrame:selfVC.view.bounds];
        
        //背景虚化设置颜色
//        [mylabel setBackgroundColor:[UIColor darkGrayColor]];
        
        //背景虚化设置透明度
//        mylabel.alpha =0.8;
        [_backgroudView addSubview:mylabel];
        

        
//不直接显示 加下划线的
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:title];
        
        NSRange contentRange = {0,[content length]};
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
        //添加颜色
        [content addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:contentRange];
     
        
        [self setAttributedTitle:content forState:UIControlStateNormal];

        
//直接显示
//        [self setTitle:title forState:UIControlStateNormal];
        
        //      [self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        // 单击的 Recognizer
      
        UITapGestureRecognizer  *   singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];

        singleRecognizer.numberOfTapsRequired = 1; // 单击
        

        
        [_backgroudView addGestureRecognizer:singleRecognizer];

        
        
        [self addTarget:self action:@selector(showImageView:) forControlEvents:UIControlEventTouchUpInside];
        
//        self.backgroundColor =[UIColor blueColor];
        
        
//设置图片大小  以及位置
        
        UIImageView * myImageView=[[UIImageView alloc]initWithFrame:CGRectMake(selfVC.view.bounds.size.width/2, selfVC.view.bounds.size.height/2, 200, 200)];
        myImageView.image =_imageViewForShow;
        [_backgroudView addSubview:myImageView];
        
        [self addSubview:_backgroudView];
        
//        [selfVC.view bringSubviewToFront:_backgroudView];
        
//        []
//        [self sendSubviewToBack:_backgroudView];
        [self bringSubviewToFront:_backgroudView];
        
//        [selfVC.view set]
        [_backgroudView setHidden:YES];
        
 
        
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (id)initWithFrame:(CGRect)frame showTextView:(UITextView *)textView Title:(NSString *)title WithTarget:(UIViewController *)selfVC
{
    
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        
        _backgroudView =[[UIView alloc]initWithFrame:selfVC.view.frame];

        
        _textViewForShow= textView;
        _selfVC= selfVC;
        _backgroudView.backgroundColor =[UIColor clearColor];
        
        
        
        UILabel * mylabel =[[UILabel alloc]initWithFrame:selfVC.view.frame];
        
//        背景虚化设置颜色
                [mylabel setBackgroundColor:[UIColor darkGrayColor]];
        
//        背景虚化设置透明度
                mylabel.alpha =0.8;
        [_backgroudView addSubview:mylabel];
        
        
        
        //不直接显示 加下划线的
//        NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:title];
//        
//        NSRange contentRange = {0,[content length]};
//        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
//        //添加颜色
//        [content addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:contentRange];
//        
//        
//        [self setAttributedTitle:content forState:UIControlStateNormal];
        
        
        //直接显示
    [self setTitle:title forState:UIControlStateNormal];
        
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        // 单击的 Recognizer
        
        UITapGestureRecognizer  *   singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
        
        singleRecognizer.numberOfTapsRequired = 1; // 单击
        
        
        
        [_backgroudView addGestureRecognizer:singleRecognizer];
        
        
        
        [self addTarget:self action:@selector(showImageView:) forControlEvents:UIControlEventTouchUpInside];
  
        
    _contentScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 300, selfVC.view.bounds.size.width, selfVC.view.bounds.size.height-300)];
      
        _contentScrollView.contentSize =   CGSizeMake(selfVC.view.bounds.size.width, [self getContenSizeAction:_textViewForShow]);
        
//       [ _textViewForShow setFrame:CGRectMake(0, 0, selfVC.view.bounds.size.width, [self getContenSizeAction:_textViewForShow])];
        
             [ _textViewForShow setFrame:CGRectMake(0, 0, selfVC.view.bounds.size.width, selfVC.view.bounds.size.height-300)];
        
//        [_contentScrollView setBackgroundColor:[UIColor blueColor]];
        [_contentScrollView addSubview:_textViewForShow];

        
        [_backgroudView addSubview:_contentScrollView];
        
        
        //        [selfVC.view bringSubviewToFront:_backgroudView];
        
        //        []
        //        [self sendSubviewToBack:_backgroudView];
        [selfVC.view addSubview:_backgroudView];
        [self bringSubviewToFront:_backgroudView];
        
        //        [selfVC.view set]
        [_backgroudView setHidden:YES];
        
        
    }
    return self;

    
    
    
    
}

//动态获取textView的高度
- (CGFloat)getContenSizeAction:(UITextView *)textView
{
    
    
    CGFloat height;
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        
        
        
        CGRect textFrame=[[textView layoutManager]usedRectForTextContainer:[textView textContainer]];
        
        height = textFrame.size.height;
        
        
        
    }else {
        
        
        
        height = textView.contentSize.height;
        
    }
    
    return height;
}





- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (void)SingleTap:(UITapGestureRecognizer *)ges
{

    
    
    [self hiddenWithAnimation:self.backgroudView];
//     [self.backgroudView setHidden:YES];
}

- (void)showImageView:(UIButton *)btn
{
    

//    [self setHidden:YES];
  
//    [self setHiddenAnimated:YES];
    
    
//   [_backgroudView setHidden:NO];
    
    [self hiddenOfNoWithAnimation:_backgroudView];
    
//    [_backgroudView seth]
    [_selfVC.view bringSubviewToFront:_backgroudView];
    
}

-(void)hiddenWithAnimation:(UIView *)hideView
{
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionReveal;
    animation.duration = 0.4;
    [hideView.layer addAnimation:animation forKey:nil];
    
    hideView.hidden = YES;
}

-(void)hiddenOfNoWithAnimation:(UIView *)hideView
{
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFromTop;
    animation.duration = 0.4;
    [hideView.layer addAnimation:animation forKey:nil];
    
    hideView.hidden = NO;
}


@end

//
//  BaseViewController.h
//  Demo4
//
//  Created by Satellite on 14/11/27.
//  Copyright (c) 2014年 Satellite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDSideMenu.h"
#import "UIViewController+JDSideMenu.h"
#import "MDMenuChildViewController.h"
#import "UserCache.h"
//#import "JDSideMenu.h"
@interface BaseViewController : MDMenuChildViewController
{
    float startX;//IOS 7或者以下 适配屏幕
    MBProgressHUD * hud;
}
-(void)buildTopviewWithBackButton:(BOOL)isHave title:(NSString *)title rightImage:(NSString *)rightImage;
-(void)buildScrollViewWithFrame:(CGRect)frame contentSize:(CGSize)size Image:(NSString *)image;
- (void) gotoViews;
-(float)niub:(float)a;

- (void)setTopViewWithTitle:(NSString*)titleStr withBackButton:(BOOL)hasBacButton;
-(void)showAlertViewWithtitle:(NSString *)title message:(NSString *)message;


/*
 *lable 高度自适应 传入数据 返回size
 *1. text ：lable.text
 *2. lable.font
 *3. maxsize
 *4. 返回CGSize
 */

- (CGSize)labelAutoCalculateRectWith:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize;

/*
 *** 
 *1. 根据传入的星座名称 返回星座图片
 *2. 传入名要带 “座” for example 白羊座
 *3. 返回类型为NSString 为星座图片名称  非UIImage类型
 */
-(NSString *)GetNameReturnImageWithName:(NSString *)name;

@property (nonatomic,strong)MBProgressHUD *hud;

- (void)showMessageWindowWithContent:(NSString*)content imageType:(NSInteger)imageType;

// [self.menuController showMenu:self.menuController.topBar ];
/*
 
 创建Label快捷方式
 */

-(UILabel *)buildLabelWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textClolr font:(UIFont *)font textAlignment:(NSTextAlignment)alignment text:(NSString*)text;

/*
 分割字符串
 */



-(NSArray*)segmentationStrign:(NSString *)str withStr:(NSString *)str1;

//判断字符串为空
-(BOOL)isEmtity:(NSString*)str;

- (void)setExtraCellLineHidden: (UITableView *)tableView;
@property(nonatomic,strong) UIButton * leftButton;


//动态获取textView的高度
- (CGFloat)getContenSizeAction:(UITextView *)textView;

@end

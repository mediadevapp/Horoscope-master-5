//
//  MineViewController.m
//  Horoscope
//
//  Created by Satellite on 14/12/11.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import "MineViewController.h"
#import "PersonInfo1Cell.h"
#import "PersonInfoCell.h"
#import "PhotoViewController.h"
#import "PersonInfoChangeViewController.h"
#import "EGOImageButton.h"
#import "FansViewController.h"
@interface MineViewController ()
{
    UIScrollView * mainScrl;
    UITableView  * myTableView;
    NSArray *arr1;
    NSArray *arr2;
    EGOImageButton *headImgView;//头像
    UIImageView * xzImgViwe;//星座图标
    UILabel *xzLabel;//星座名称
    UILabel *ageLabel;//年龄
    UILabel * qmLabel;//签名
    UIButton * funsBtn;//粉丝BTN
    UIButton * gzBtn;//关注Btn
    UIImageView * sexImageView;
    UILabel *titleLabel;
    UILabel *useridLabel;
    
    UIActionSheet * photoSheet;
    NSMutableDictionary * infoDict;
    NSMutableArray * photoWallArray;
    UILabel * tisLb;
}
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.isRootView) {
        
        [self setTopViewWithTitle:@"" withBackButton:YES];
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-60, KISHighVersion_7?20:0, 60, 44)];
        [button setImage:KUIImage(@"editor") forState:UIControlStateNormal];
        [button addTarget:self action:@selector(enterNextPage:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];

    }else{
        [self setTopViewWithTitle:@"" withBackButton:YES];
    }
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, KISHighVersion_7?20:0, self.view.bounds.size.width-140, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:22];
    titleLabel.textAlignment =NSTextAlignmentCenter;
    titleLabel.backgroundColor= [UIColor clearColor];
    titleLabel.text = @"用户";
    titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    
    infoDict = [NSMutableDictionary dictionary];
    photoWallArray = [NSMutableArray new];
    
    mainScrl =[[ UIScrollView alloc]initWithFrame:CGRectMake(0, KISHighVersion_7?64:44, KScreenWidth, KScreenHeight-(KISHighVersion_7?64:44))];
    mainScrl.backgroundColor = [UIColor whiteColor];

    mainScrl.contentSize  = CGSizeMake(0, KScreenWidth/2-30+KScreenWidth*0.52+100+40*9+10);
    
    [self.view addSubview:mainScrl];
    [self buildFirstView];
    
//    [self buildPhotosWall];

    myTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, KScreenWidth/2+KScreenWidth*.52-30, KScreenWidth, 100+40*9+10) style:UITableViewStylePlain];
    myTableView.bounces = NO;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    
    [mainScrl addSubview:myTableView];
//    arr1 = [NSArray arrayWithObjects:@"情感状态",@"外貌",@"职业",@"爱好",@"语言",@"出生地",@"学校",@"公司", nil];
//    arr2 = [NSArray arrayWithObjects:@"单身",@"180cm 55kg 强壮",@"学生",@"泡妞 游戏 电影 读书",@"中 英 法 德 西班牙 日 韩 俄罗斯 意大利",@"China",@"英国剑桥",@"SF", nil];
    
    
//    [self setIsRootView:NO];
    hud = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:hud];
    [self getInfoFromNetWithUserId:self.userid];
    
    
}

-(void)getInfoFromNetWithUserId:(NSString *)userid
{
    hud.labelText = @"获取中...";
    [hud show:YES];
    NSString *urlStr ;
    if (self.isRootView) {
        urlStr = [NSString stringWithFormat:@"userdetail.php?uid=%@",[[UserCache sharedInstance]objectForKey:KMYUSERID ]];
    }else{
        urlStr = [NSString stringWithFormat:@"userdetail.php?uid=%@",userid];
    }
    
     [[AFAppDotNetAPIClient sharedClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
          [hud hide:YES];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            infoDict = [NSMutableDictionary dictionaryWithDictionary:responseObject];
            
            if ([userid isEqualToString:[[UserCache sharedInstance]objectForKey:KMYUSERID]]) {
                [[UserCache sharedInstance]setObject:infoDict forKey:MYINFODICT];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"LOIGNSUCCESS_WX_LIANGSHABI" object:nil];
            }
            
            headImgView.imageURL = [NSURL URLWithString:KISDictionaryHaveKey(infoDict, @"photo")];
//            xzImgViwe.image = KUIImage(@"");
            [photoWallArray removeAllObjects];
            photoWallArray = [NSMutableArray arrayWithArray:[self segmentationStrign:KISDictionaryHaveKey(responseObject, @"pics") withStr:@"#"]];
            
            [self buildPhotosWallWithUrl:photoWallArray];
            NSString *sexStr = KISDictionaryHaveKey(infoDict, @"sex");
            if ([sexStr isEqualToString:@"男"]) {
                sexImageView.image = KUIImage(@" Male");
            }else{
                 sexImageView.image = KUIImage(@"Female");
            }
            xzLabel.text = KISDictionaryHaveKey(infoDict, @"xing");
            qmLabel.text = KISDictionaryHaveKey(infoDict, @"phrase");
            CGSize size = [self labelAutoCalculateRectWith:KISDictionaryHaveKey(infoDict, @"phrase") FontSize:14 MaxSize:CGSizeMake(width(self.view)-sx(headImgView)-20, 40)];
            qmLabel.frame = CGRectMake(sx(headImgView)+10, sy(xzImgViwe)+5, width(self.view)-sx(headImgView)-20, size.height);
            qmLabel.numberOfLines = 0;
            
            
            titleLabel.text = KISDictionaryHaveKey(infoDict, @"nickname");
            ageLabel.text = KISDictionaryHaveKey(infoDict, @"userage");
            useridLabel.text = [NSString stringWithFormat:@"ID:%@",KISDictionaryHaveKey(infoDict,@"id")];
            [funsBtn setTitle:[NSString stringWithFormat:@"粉丝 %@",KISDictionaryHaveKey(infoDict,@"fans")] forState:UIControlStateNormal];
            [gzBtn setTitle:[NSString stringWithFormat:@"关注 %@",KISDictionaryHaveKey(infoDict,@"follow")] forState:UIControlStateNormal];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [hud hide:YES];
        [self showAlertViewWithtitle:@"提示" message:@"请求失败"];
    }];
}
//创建第一条
-(void)buildFirstView
{
    UIView * blackView =[[ UIView alloc]initWithFrame:CGRectMake(0,1, KScreenWidth, KScreenWidth/2-30)];
    blackView.backgroundColor =[ UIColor blackColor];
    [mainScrl addSubview:blackView];
    
    //头像
   headImgView =[[ EGOImageButton alloc]initWithFrame:CGRectMake(30, 15, (width(blackView)/2-30)/2, (width(blackView)/2-30)/2)];
    headImgView.placeholderImage = KUIImage(@"placeholder.jpg");
    headImgView.layer.masksToBounds = YES;
    headImgView.layer.cornerRadius = (width(blackView)/2-30)/4;

    //如果是自己的信息 可以更改头像
    
    if (self.isRootView) {
        [headImgView addTarget:self action:@selector(changeHeadImage:) forControlEvents:UIControlEventTouchUpInside];
    }
    [blackView addSubview:headImgView];
    
    //星座图标
    xzImgViwe = [[UIImageView alloc]initWithFrame:CGRectMake(sx(headImgView)+10, 20, 40,40)];
    xzImgViwe.image = KUIImage(@"ys_c_sp");
    [blackView addSubview:xzImgViwe];
    
    //星座LB
    xzLabel = [[UILabel alloc]initWithFrame:CGRectMake(sx(xzImgViwe)+5, 30, 60, 20)];
    xzLabel.textColor = [UIColor whiteColor];
    xzLabel.font = [UIFont boldSystemFontOfSize:18];
    xzLabel.backgroundColor = [UIColor clearColor];
    xzLabel.text = @"水瓶座";
    xzLabel.textAlignment = NSTextAlignmentLeft;
    [blackView addSubview:xzLabel];
    
    
    sexImageView = [[UIImageView alloc]initWithFrame:CGRectMake(sx(xzLabel)+10, 30, 20, 20)];
    [blackView addSubview:sexImageView];
    
    //年龄LB
    ageLabel = [self buildLabelWithFrame:CGRectMake(sx(xzLabel)+40, 30, 70, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:18] textAlignment:NSTextAlignmentLeft text:@"22"];
    [blackView addSubview:ageLabel];
    
    
    
    //签名LB
    qmLabel = [self buildLabelWithFrame:CGRectMake(sx(headImgView)+10, sy(xzImgViwe)+5, 200, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft text:@"no zuo no die why you try?"];
    [blackView addSubview:qmLabel];
    
    UIImageView*lineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, height(blackView)-42, width(blackView), 2)];
    lineView.image = KUIImage(@"dotted line");
    [blackView addSubview:lineView];
    
    funsBtn= [[UIButton alloc]initWithFrame:CGRectMake(0, height(blackView)-40, width(blackView)*0.56, 40)];
    
    funsBtn.backgroundColor = [UIColor clearColor];
    [funsBtn setTitle:@"粉丝 205" forState:UIControlStateNormal];
    [funsBtn addTarget:self action:@selector(didClickFuns:) forControlEvents:UIControlEventTouchUpInside];
    [blackView addSubview:funsBtn];
    
    UIImageView *lineLView = [[UIImageView alloc]initWithFrame:CGRectMake(width(blackView)*0.56, height(blackView)-40, 2, 40)];
    lineLView.image = KUIImage(@"line");
    [blackView addSubview:lineLView];
    
    gzBtn= [[UIButton alloc]initWithFrame:CGRectMake(width(blackView)*0.56+2, height(blackView)-40, width(blackView)-width(blackView)*0.56+2, 40)];
    
    gzBtn.backgroundColor = [UIColor clearColor];
    [gzBtn addTarget:self action:@selector(didClickgz:) forControlEvents:UIControlEventTouchUpInside];
    [gzBtn setTitle:@"关注 250" forState:UIControlStateNormal];
    [blackView addSubview:gzBtn];
        
}

//坑爹的照片墙
-(void)buildPhotosWallWithUrl:(NSMutableArray *)url
{
    
    UIView *customView;
    [customView removeFromSuperview];
    customView = [[UIView alloc]initWithFrame:CGRectMake(0,KScreenWidth/2-30, KScreenWidth, KScreenWidth*0.52)];
    [mainScrl addSubview:customView];
    
    
   UIScrollView * photoView =[[ UIScrollView alloc]initWithFrame:CGRectMake(0,0, KScreenWidth, KScreenWidth*0.52)];
    photoView.backgroundColor = [UIColor whiteColor];
    [customView addSubview:photoView];
    NSLog(@"%lu",(unsigned long)url.count);
    if (url.count<9) {
        for (int i = 0; i<url.count; i++) {
            
            CGFloat imgWidth = (width(mainScrl)-30)/4;
            CGFloat imgY = 10 +imgWidth*(i/4)+i/4*5;
            CGFloat imgX = 7 + imgWidth*(i%4)+(i%4)*5;
            NSLog(@"%d----%d--%d--%d",4%4,5%4,6%4,7%4);
            EGOImageButton  *imgView =[[ EGOImageButton alloc]initWithFrame:CGRectMake(imgX,imgY, imgWidth, imgWidth)];
            imgView.placeholderImage = KUIImage(@"placeholder.jpg") ;
            
            if ([url[i]isKindOfClass:[UIImage class]]) {
                [imgView setImage:url[i] forState:UIControlStateNormal] ;
            }else
                imgView.imageURL = [NSURL URLWithString:url[i]];
            imgView.tag = i;
            [imgView addTarget:self action:@selector(seeBigImg:) forControlEvents:UIControlEventTouchUpInside];
            [photoView addSubview:imgView];
        }
    }else{
        int count = url.count;
        int num ;
        if (count%2==1) {
            num = count/2+1;
        }
        else{
            num = count/2;
        }
        photoView.contentSize = CGSizeMake((width(mainScrl)-30)/4*num+num*5+10, 0);

        for (int i = 0; i<url.count; i++) {
            CGFloat imgWidth = (width(mainScrl)-30)/4;
            CGFloat imgX = 7 + imgWidth*(i%num)+(i%num)*5;
            CGFloat imgY = 10 +imgWidth*(i/num)+i/num*5;
            
            NSLog(@"%d----%d--%d--%d--%d",i/num,i%num,0,0,0);
            
            EGOImageButton  *imgView =[[ EGOImageButton alloc]initWithFrame:CGRectMake(imgX,imgY, imgWidth, imgWidth)];
            imgView.placeholderImage = KUIImage(@"placeholder.jpg") ;
            
            if ([url[i]isKindOfClass:[UIImage class]]) {
                [imgView setImage:url[i] forState:UIControlStateNormal] ;
            }else
                imgView.imageURL = [NSURL URLWithString:url[i]];
            imgView.tag = i;
            [imgView addTarget:self action:@selector(seeBigImg:) forControlEvents:UIControlEventTouchUpInside];
            [photoView addSubview:imgView];

        }
    }
    
    if (self.isRootView) {
        UIButton *addBtn;
        if (!addBtn) {
            addBtn=[[UIButton alloc]initWithFrame:CGRectMake(width(photoView)/2-15, height(photoView)/2-15, 30, 30)];
            addBtn.backgroundColor = [UIColor clearColor];
            [addBtn setBackgroundImage:KUIImage(@"m_addPhoto_normal") forState:UIControlStateNormal];
            [addBtn addTarget:self action:@selector(addImage:) forControlEvents:UIControlEventTouchUpInside];
            [customView bringSubviewToFront:addBtn];
            [customView addSubview:addBtn];
        }
      
    }
    
    
    tisLb = [self buildLabelWithFrame:CGRectMake(0, height(photoView)/2+20, width(photoView), 15) backgroundColor:[UIColor clearColor] textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentCenter text:@"主人尚未上传照片"];
    tisLb.hidden = YES;
    [customView addSubview:tisLb];
    
    if ([url isKindOfClass:[NSArray class]]&&url.count>0) {
        tisLb.hidden = YES;
    }else{
        tisLb.hidden = NO;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 0;
            break;
        default:
            return 0;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        static NSString * identifier1 = @"cell1";
        PersonInfo1Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (!cell) {
            cell = [[PersonInfo1Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
        }
        cell.accessoryType = YES;
        return cell;
    }else{
    static NSString *identifier = @"cell";
    PersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier ];

    if (!cell) {
        cell = [[PersonInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.titleLabel.text= arr1[indexPath.row];
    cell.ctLabel.text = arr2[indexPath.row];
    return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section ==0) {
        
    }

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor grayColor];
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 1, KScreenWidth, 50-2)];
        view1.backgroundColor = [UIColor whiteColor];
        [view addSubview:view1];
        
        UILabel *lb1 = [self buildLabelWithFrame:CGRectMake(0, 0, 80, 40) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] font:[UIFont boldSystemFontOfSize:17] textAlignment:NSTextAlignmentRight text:@"基本资料"];
        [view1 addSubview:lb1];
        
        useridLabel = [self buildLabelWithFrame:CGRectMake(KScreenWidth-200, 0, 180, 40) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] font:[UIFont boldSystemFontOfSize:17] textAlignment:NSTextAlignmentRight text:@"星缘号:"];
        [view1 addSubview:useridLabel];

        return view;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 0;
            break;
        default:
            return 50;
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return 80;
    }else{
        return 40;
    }
}

#pragma mark---ADD image
-(void)addImage:(UIButton *)sender
{
    NSUInteger i = [[NSString stringWithFormat:@"%lu",(unsigned long)[photoWallArray count]]intValue];
    if (i>29) {
        [self showAlertViewWithtitle:@"提示" message:@"您的照片已达到上限"];
        return;
    }
    
    if (!photoSheet) {
        photoSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
    }
    self.isUpLoadHeadImg = NO;
    [photoSheet showInView:self.view];

}



//点击 粉丝
-(void)didClickFuns:(UIButton *)sender
{
//    UIAlertView *ale = [[UIAlertView alloc]initWithTitle:@"提示" message:@"粉丝250" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//    [ale show];
    
    FansViewController *fans = [[FansViewController alloc]init];
    fans.isFans = YES;
    [self.menuController pushViewController:fans withTransitionAnimator:[MDTransitionAnimatorFactory transitionAnimatorWithType:MDAnimationTypeSlideFromRight]];

}

//点击关注
-(void)didClickgz:(UIButton *)sender
{
//    UIAlertView *ale = [[UIAlertView alloc]initWithTitle:@"提示" message:@"关注250" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//    [ale show];
    
    FansViewController *fans = [[FansViewController alloc]init];
    fans.isFans = NO;
    [self.menuController pushViewController:fans withTransitionAnimator:[MDTransitionAnimatorFactory transitionAnimatorWithType:MDAnimationTypeSlideFromRight]];
    
}

-(void)seeBigImg:(UIButton *)sender
{
    PhotoViewController *photoVC = [[PhotoViewController alloc]init];
    photoVC.photoArray = [NSMutableArray array];
    [photoVC.photoArray addObjectsFromArray:[self segmentationStrign:[infoDict objectForKey:@"pics"] withStr:@"#"]];
    
    photoVC.num = sender.tag;
    photoVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
//    [self presentViewController:photoVC animated:YES completion:^{
//    }];
    
    [self.menuController pushViewController:photoVC withTransitionAnimator:[MDTransitionAnimatorFactory transitionAnimatorWithType:MDAnimationTypeSlideFromRight]];
    
}

//进入设置界面
-(void)enterNextPage:(id)sender
{
    PersonInfoChangeViewController * p= [[PersonInfoChangeViewController alloc]init];
    p.infoDict = [NSMutableDictionary dictionaryWithDictionary:infoDict];
    [self.menuController pushViewController:p withTransitionAnimator:[MDTransitionAnimatorFactory transitionAnimatorWithType:MDAnimationTypeNone]];

}

-(void)changeHeadImage:(id)sender
{
    if (!photoSheet) {
        photoSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
    }
    self.isUpLoadHeadImg = YES;
    [photoSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            UIImagePickerController * imagePicker;
            if (imagePicker==nil) {
                imagePicker=[[UIImagePickerController alloc]init];
                imagePicker.delegate=self;
                imagePicker.allowsEditing = YES;
            }
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
                imagePicker.delegate = self;
                [self presentViewController:imagePicker animated:YES completion:^{
                    
                }];
            }
            else {
                UIAlertView *cameraAlert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您的设备不支持相机" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
                [cameraAlert show];
            }
        }break;
        case 1:
        {
            UIImagePickerController * imagePicker;
            if (imagePicker==nil) {
                imagePicker=[[UIImagePickerController alloc]init];
                imagePicker.delegate=self;
                imagePicker.allowsEditing = YES;
            }
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
                
                [self presentViewController:imagePicker animated:YES completion:^{
                    
                }];
            }
            else {
                UIAlertView *libraryAlert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您的设备不支持相册" delegate:self cancelButtonTitle:@"了解" otherButtonTitles:nil];
                [libraryAlert show];
            }
        }break;
        default:
            break;
            
            
    }

}
#pragma mark----imagepick delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    UIImage*selectImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    if (picker.sourceType ==UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(selectImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    
    if (self.isUpLoadHeadImg) {
        hud.labelText = @"上传中...";
        [hud show:YES];
        [headImgView setImage:selectImage forState:UIControlStateNormal];
        NSData * imgData = UIImageJPEGRepresentation(selectImage,1.0);
        if (imgData) {
            NSString *urlStr = [NSString stringWithFormat:@"uploader/uppoo"];
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            //
            [dic setObject:[[UserCache sharedInstance]objectForKey:KMYUSERID ] forKey:@"uid"];
            
            NSString *uuid = [TempDate uuid];
            
            [[AFAppDotNetAPIClient sharedClient]POST:urlStr parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                [formData appendPartWithFileData:imgData name:@"file" fileName:[NSString stringWithFormat:@"%@.jpg",uuid] mimeType:@"image/jpeg"];
                
            } success:^(NSURLSessionDataTask *task, id responseObject) {
                [hud hide:YES];
                [self getInfoFromNetWithUserId:[[UserCache sharedInstance]objectForKey:KMYUSERID]];
                [self showMessageWindowWithContent:@"修改成功"imageType:0];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                hud.labelText = @"上传失败";
                [hud hide: YES];
                
            }];
    }
    }else{
        /*
         
         ********
    ------添加照片墙
         ********
         */
        hud.labelText = @"上传中...";
        [hud show:YES];
        [photoWallArray insertObject:selectImage atIndex:0];
        [self buildPhotosWallWithUrl:photoWallArray];
        
        NSString *urlStr = [NSString stringWithFormat:@"addpics"];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        //
        [dic setObject:[[UserCache sharedInstance]objectForKey:KMYUSERID ] forKey:@"uid"];
        [dic setObject:@"1" forKey:@"uploadN"];
        NSString *uuid = [TempDate uuid];
        
        float width  =0.0;
        float height = 0.0;
        if (selectImage.size.width>KScreenWidth) {
            width = KScreenWidth;
            height = selectImage.size.height *(KScreenWidth/selectImage.size.width);
        }else{
            width = selectImage.size.width;
            height = selectImage.size.height;
        }
        
        
        UIImage *img = [self imageWithImageSimple:selectImage scaledToSize:CGSizeMake(width, height)];
        
        NSData * imgData = UIImageJPEGRepresentation(img,1.0);

        [[AFAppDotNetAPIClient sharedClient]POST:urlStr parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:imgData name:@"file" fileName:[NSString stringWithFormat:@"%@.jpg",uuid] mimeType:@"image/jpeg"];
        } success:^(NSURLSessionDataTask *task, id responseObject) {
            [hud hide: YES];
            [self showMessageWindowWithContent:@"上传成功"imageType:0];
            [self getInfoFromNetWithUserId:[[UserCache sharedInstance]objectForKey:KMYUSERID]];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [hud hide: YES];
        }];
    }
}


- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}




- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

-(NSString *)getNameReturnStar:(NSString *)name
{
    if ([name isEqualToString:@"白羊座"]) {
        return @"ys_c_by";
    }
    else if ([name isEqualToString:@"处女座"])
    {
        return @"ys_c_chunv";
    }
    else if ([name isEqualToString:@"天蝎座"])
    {
        return @"ys_c_tx";
    }
    else if ([name isEqualToString:@"天秤座"])
    {
        return @"ys_c_tc";
    }
    
    else if ([name isEqualToString:@"双子座"])
    {
        return @"ys_c_sz";
    }
    else if ([name isEqualToString:@"摩羯座"])
    {
        return @"ys_c_mojie";
    }
    else if ([name isEqualToString:@"双鱼座"])
    {
        return @"ys_c_sy";
    }
    else if ([name isEqualToString:@"射手座"])
    {
        return @"ys_c_sheshou";
    }
    else if ([name isEqualToString:@"巨蟹座"])
    {
        return @"ys_c_juxie";
    }
    else if ([name isEqualToString:@"狮子座"])
    {
        return @"ys_c_shizi";
    }
    else if ([name isEqualToString:@"金牛座"])
    {
        return @"ys_c_jinniu";
    }
    else if ([name isEqualToString:@"水瓶座"])
    {
        return @"ys_c_sp";
    }
    return nil;
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

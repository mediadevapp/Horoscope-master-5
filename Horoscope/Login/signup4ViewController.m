//
//  signup4ViewController.m
//  Horoscope
//
//  Created by SAT on 15/1/9.
//
//

#import "signup4ViewController.h"
#import "NewMainViewController.h"
@interface signup4ViewController ()

@end

@implementation signup4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTopViewWithTitle:@"第四步" withBackButton:NO];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth-60, KISHighVersion_7?20:0, 60, 44)];
//    [button setImage:KUIImage(@"wancheng.png") forState:UIControlStateNormal];
    [button setTitle:@"跳过" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(enterNextPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.faceButton setBackgroundImage:KUIImage(@"userDefalt") forState:UIControlStateNormal];
    [self.view addSubview:button];

    // Do any additional setup after loading the view from its nib.
}
-(void)enterNextPage:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)getPhotoFromBooth:(id)sender {
    
//    UIImagePickerController * imagePicker;
       UIImagePickerController * imagePicker=[[UIImagePickerController alloc]init];
        imagePicker.delegate=self;
        imagePicker.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:imagePicker animated:YES completion:^{
            
        }];
    }
    else {
        UIAlertView *libraryAlert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您的设备不支持相册" delegate:self cancelButtonTitle:@"了解" otherButtonTitles:nil];
        [libraryAlert show];
    }

}
- (IBAction)getPhotoFromeCamere:(id)sender {
    
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
    
        [self.faceButton setBackgroundImage:selectImage forState:UIControlStateNormal];
    
    
    
        NSData * imgData = UIImageJPEGRepresentation(selectImage,1.0);
        if (imgData) {
            NSString *urlStr = [NSString stringWithFormat:@"uploader/uppoo"];
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            //
            [dic setObject:[[UserCache sharedInstance]objectForKey:KMYUSERID ] forKey:@"uid"];
            
            NSString *uuid = [TempDate uuid];
            hud.labelText = @"上传中...";
            [hud show:YES];
            [[AFAppDotNetAPIClient sharedClient]POST:urlStr parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                [formData appendPartWithFileData:imgData name:@"file" fileName:[NSString stringWithFormat:@"%@.jpg",uuid] mimeType:@"image/jpeg"];
            } success:^(NSURLSessionDataTask *task, id responseObject) {
                [hud hide:YES];
                [self showMessageWindowWithContent:@"设置成功"imageType:0];
//                NewMainViewController * mainVC =[[NewMainViewController alloc]init];
//                [self.menuController pushViewController:mainVC withTransitionAnimator:[MDTransitionAnimatorFactory transitionAnimatorWithType:MDAnimationTypeSlideFromRight]];
//                
//                [self.menuController popViewControllerWithTransitionAnimator:nil];
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [hud hide: YES];
            }];
        }
}


- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
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

//
//  SendCircleViewController.m
//  Horoscope
//
//  Created by Satellite on 15/1/7.
//
//

#import "SendCircleViewController.h"

@interface SendCircleViewController ()
{
    UITextView * senderTextView;
    UIActionSheet * cActionSheet;
    UIButton *photoBtn;
    
    NSData *imgData;
    NSString * fielPath;
}
@end

@implementation SendCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTopViewWithTitle:@"发表说说" withBackButton:YES];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-60, KISHighVersion_7?20:0, 60, 44)];
    [button setImage:KUIImage(@"123123") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(senderNewCircle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    senderTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, startX, width(self.view), width(self.view)/2)];
    senderTextView.font = [UIFont systemFontOfSize:14];
    senderTextView.backgroundColor = [UIColor colorWithRed:180/225.0f green:180/225.0f blue:180/225.0f alpha:1];
    [self.view addSubview:senderTextView];
    
    self.view .backgroundColor = [UIColor whiteColor];
    
    photoBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 20+sy(senderTextView), 106, 106)];
    
//    if (self.img) {
//        [photoBtn setBackgroundImage:self.img forState:UIControlStateNormal];
//    }else
    [photoBtn setBackgroundImage:KUIImage(@"tianjia-Normal") forState:UIControlStateNormal];
    [photoBtn addTarget:self action:@selector(addImg:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:photoBtn];
    hud = [[MBProgressHUD alloc]initWithView:self.view];
    hud.labelText = @"发送中...";
    [self.view addSubview:hud];
    // Do any additional setup after loading the view.
}

#pragma mark ----add img
-(void)addImg:(UIButton *)sender
{
    if (!cActionSheet) {
        cActionSheet = [[UIActionSheet alloc]initWithTitle:@"选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
    }
    [cActionSheet showInView:self.view];

}

#pragma mark ---imagepickerdelegate
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
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSMutableDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    UIImage*selectImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    if (picker.sourceType ==UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(selectImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    [photoBtn setImage:selectImage forState:UIControlStateNormal];
    
    imgData = UIImageJPEGRepresentation(selectImage,1.0);
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    
}



#pragma mark----发送
-(void)senderNewCircle:(UIButton *)sender
{
    if ([self isEmtity:senderTextView.text]) {
        [self showAlertViewWithtitle:@"提示" message:@"请输入文字"];
        return;
    }
        NSString *urlStr = [NSString stringWithFormat:@"addpiccontent"];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//
        [dic setObject:[[UserCache sharedInstance]objectForKey:KMYUSERID] forKey:@"uid"];
        [dic setObject:senderTextView.text forKey:@"content"];
        
        NSString *uuid = [TempDate uuid];
    [hud show:YES];
[[AFAppDotNetAPIClient sharedClient]POST:urlStr parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    if (imgData) {
        [formData appendPartWithFileData:imgData name:@"file" fileName:[NSString stringWithFormat:@"%@.jpg",uuid] mimeType:@"image/jpeg"];
    }
} success:^(NSURLSessionDataTask *task, id responseObject) {
    [hud hide:YES];
    [self showMessageWindowWithContent:@"发表成功"imageType:0];
    
    [self.menuController popViewControllerAnimated:YES];
} failure:^(NSURLSessionDataTask *task, NSError *error) {
    [hud hide:YES];
    
    [self showAlertViewWithtitle:@"提示" message:@"发送失败，请检查网络"];
}];
        
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

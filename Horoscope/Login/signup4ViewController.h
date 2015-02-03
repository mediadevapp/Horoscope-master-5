//
//  signup4ViewController.h
//  Horoscope
//
//  Created by SAT on 15/1/9.
//
//

#import "BaseViewController.h"

@interface signup4ViewController : BaseViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *faceButton;
@property (weak, nonatomic) IBOutlet UIButton *photoBooth;
@property (weak, nonatomic) IBOutlet UIButton *takePhoto;
@end

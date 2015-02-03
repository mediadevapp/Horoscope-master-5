//
//  SendCircleViewController.h
//  Horoscope
//
//  Created by Satellite on 15/1/7.
//
//

#import "BaseViewController.h"

@interface SendCircleViewController : BaseViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong)UIImage * img;
@end

//
//  signup3ViewController.h
//  Horoscope
//
//  Created by SAT on 15/1/9.
//
//

#import "BaseViewController.h"

@interface signup3ViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *nicheng;
@property (copy, nonatomic) NSString *telPhoneNumber;
@property (copy, nonatomic) NSString *passWordStr;
@property (weak, nonatomic) IBOutlet UIButton *nan;
@property (weak, nonatomic) IBOutlet UIButton *nv;
@property (weak, nonatomic) IBOutlet UIButton *pickViewButton;
@property (weak, nonatomic) IBOutlet UIButton *xingzuoButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *dataPicker;
- (IBAction)didClickMan:(UIButton *)sender;
- (IBAction)didClickWoman:(UIButton *)sender;
- (IBAction)didClickDataPicker:(UIButton *)sender;

@end

//
//  testDetailedViewController.h
//  Horoscope
//
//  Created by SAT on 14/12/29.
//
//

#import "BaseViewController.h"

@interface testDetailedViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *topImage;

@property (weak, nonatomic) IBOutlet UILabel *testNumber;
@property (weak, nonatomic) IBOutlet UILabel *sucNumber;

@property (weak, nonatomic) IBOutlet UILabel *times;

@property (weak, nonatomic) IBOutlet UITextView *contentText;

@end

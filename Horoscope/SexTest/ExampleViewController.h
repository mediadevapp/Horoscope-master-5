//
//  ExampleViewController.h
//  Horoscope
//
//  Created by SAT on 15/1/4.
//
//

#import "BaseViewController.h"
#import "RadioButton.h"
#import "QRadioButton.h"
@class MBButtonShowView;
@interface ExampleViewController : BaseViewController<QRadioButtonDelegate>

@property (nonatomic,strong)NSMutableArray * exampleArray;
//@property (nonatomic,strong)NSMutableArray * answerArray;
@property (nonatomic,strong)NSMutableDictionary  * exampleDic;
@property (nonatomic)NSInteger selectedNum;

@property(nonatomic,strong)NSMutableArray * answerArray;





@property (weak, nonatomic) IBOutlet UILabel *testCount;
@property (weak, nonatomic) IBOutlet UILabel *zhunLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UITextView *textTitle;
@property (weak, nonatomic) IBOutlet UIView *headViews;

@property (weak, nonatomic) IBOutlet UIScrollView *contentSrollView;



@property (nonatomic,strong)UIScrollView * answerScrolllView;
@property (nonatomic,strong)UITextView * answerText;
@property (nonatomic,strong)MBButtonShowView * showOtherButton;




@property (nonatomic,strong)UIButton * submitButton;

@property (nonatomic,strong)UITextView * exampleTitle;

@end

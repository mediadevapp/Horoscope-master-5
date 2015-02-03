//
//  XWCell.h
//  Horoscope
//
//  Created by Satellite on 15/1/26.
//
//

#import <UIKit/UIKit.h>
#import "EGOImageButton.h"
#import "EGOImageView.h"
@protocol XwCellDelegate;
@interface XWCell : UITableViewCell
@property (strong, nonatomic)  UIButton *share;
@property (strong, nonatomic)  EGOImageButton *facePic;
@property (strong, nonatomic)  UILabel *titleName;
@property (strong, nonatomic)  UILabel *newsTime;
@property (strong, nonatomic)  UITextView *newsText;
@property (strong, nonatomic)  EGOImageView *newsPic;
@property (nonatomic,assign) id<XwCellDelegate>delegate;

@end

@protocol XwCellDelegate <NSObject>

-(void)didClickShareWithCell:(XWCell *)cell;

@end

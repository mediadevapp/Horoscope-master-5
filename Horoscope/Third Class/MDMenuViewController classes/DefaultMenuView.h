//
//  DefaultMenuView.h
//  MDMenuViewController Demo
//
//  Created by Mohammed Eldehairy on 5/4/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import "MenuView.h"
#import "EGOImageButton.h"
@class MDMenuViewController;
@interface DefaultMenuView : MenuView<UITableViewDataSource,UITableViewDelegate,MenuViewCellViewDelegate>
{
    UITableView *tableView;
    NSArray *MenuItems;
    BOOL firstLoad;
}
@property (nonatomic,strong)UIView * headView;
@property (nonatomic,strong)EGOImageButton * faceImageButton;
@property (nonatomic,strong)UILabel * name;
@property (nonatomic,strong)UIButton * settingButton;
//@property (nonatomic,strong)MDMenuViewController * menuVC;
@end

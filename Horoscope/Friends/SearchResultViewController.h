//
//  SearchResultViewController.h
//  Horoscope
//
//  Created by Satellite on 14/12/25.
//
//

#import "BaseViewController.h"
#import "FriendsCell.h"

@interface SearchResultViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSMutableArray * infoArray;

@end

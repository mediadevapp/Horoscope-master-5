//
//  AddressBookViewController.h
//  Horoscope
//
//  Created by Satellite on 15/1/19.
//
//

#import "BaseViewController.h"
#import <MessageUI/MessageUI.h>

@interface AddressBookViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,MFMessageComposeViewControllerDelegate,UISearchDisplayDelegate,UISearchBarDelegate>

@end

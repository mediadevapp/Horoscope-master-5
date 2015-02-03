//
//  AddressBookViewController.m
//  Horoscope
//
//  Created by Satellite on 15/1/19.
//
//

#import "AddressBookViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "ZCAddressBook.h"
#import "pinyin.h"
@interface AddressBookViewController ()
{
    UITableView *myTabelView;
    NSMutableDictionary *addressBookDic;
    NSMutableArray * keysArr;
//    NSMutableArray * searchArr;
//    NSMutableDictionary * searchDic;
    
    UISearchBar * mSearchBar;
    UISearchDisplayController *searchController;
}
@end

@implementation AddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    myTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, KISHighVersion_7?64:44, KScreenWidth, KScreenHeight-(KISHighVersion_7?64:44))];
    
    myTabelView.delegate = self;
    myTabelView.dataSource = self;
//    myTabelView.rowHeight = 90;
    [self.view addSubview:myTabelView];
    
    //初始化搜索条
    mSearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [mSearchBar setPlaceholder:@"关键字搜索"];
    mSearchBar.delegate = self;
    [mSearchBar sizeToFit];
    //初始化UISearchDisplayController
    searchController = [[UISearchDisplayController alloc] initWithSearchBar:mSearchBar contentsController:self];
    [searchController setDelegate:self];
    [searchController setSearchResultsDataSource:self];
    [searchController setSearchResultsDelegate:self];
//    searchController.searchResultsTableView.tableHeaderView = mSearchBar;
    myTabelView.tableHeaderView = mSearchBar;

    [self setTopViewWithTitle:@"手机通讯录" withBackButton:YES];

    addressBookDic =[NSMutableDictionary dictionary];
    keysArr = [NSMutableArray array];
//    searchArr = [NSMutableArray array];
//    searchDic = [NSMutableDictionary dictionary];
//   addressBookArr= [self getAddressBook];
    
    [self resetSearch];
    
    [myTabelView reloadData];
}
/*
- (NSMutableArray*)getAddressBook
{
    [hud show:YES];
    NSMutableArray * addressArray = [NSMutableArray array];
    //取得本地通信录名柄
    ABAddressBookRef tmpAddressBook = nil;
    tmpAddressBook=ABAddressBookCreateWithOptions(NULL, NULL);
    dispatch_semaphore_t sema=dispatch_semaphore_create(0);
    ABAddressBookRequestAccessWithCompletion(tmpAddressBook, ^(bool greanted, CFErrorRef error){
        dispatch_semaphore_signal(sema);
    });
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    //取得本地所有联系人记录
    if (tmpAddressBook==nil) {
        return nil;
    };
    NSArray* tmpPeoples = (__bridge NSArray*)ABAddressBookCopyArrayOfAllPeople(tmpAddressBook);
    for(id tmpPerson in tmpPeoples)
    {
        //获取的联系人单一属性:First name
        NSString* tmpFirstName = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonFirstNameProperty);
        //获取的联系人单一属性:Last name
        NSString* tmpLastName = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonLastNameProperty);
        //获取的联系人单一属性:Generic phone number
        ABMultiValueRef tmpPhones = ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonPhoneProperty);
        for(NSInteger j = 0; j < ABMultiValueGetCount(tmpPhones); j++)
        {
            NSString* tmpPhoneIndex = (__bridge NSString*)ABMultiValueCopyValueAtIndex(tmpPhones, j);
            tmpPhoneIndex = [tmpPhoneIndex stringByReplacingOccurrencesOfString:@"-"withString:@""];
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            if (tmpLastName&&tmpFirstName) {
                [dic setObject:[NSString stringWithFormat:@"%@%@",tmpLastName,tmpFirstName] forKey:@"name"];
                [dic setObject:tmpPhoneIndex forKey:@"mobileid"];
                [addressArray addObject:dic];
                
            }else if (tmpLastName)
            {
                [dic setObject:[NSString stringWithFormat:@"%@",tmpLastName] forKey:@"name"];
                [dic setObject:tmpPhoneIndex forKey:@"mobileid"];
                [addressArray addObject:dic];
            }else if (tmpFirstName)
            {
                [dic setObject:[NSString stringWithFormat:@"%@",tmpFirstName] forKey:@"name"];
                [dic setObject:tmpPhoneIndex forKey:@"mobileid"];
                [addressArray addObject:dic];
            }
        }
        CFRelease(tmpPhones);
    }
    CFRelease(tmpAddressBook);
    
    return addressArray;
}
*/

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return keysArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = [addressBookDic objectForKey:keysArr[section]];
    return arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    NSDictionary *dic = [[addressBookDic objectForKey:keysArr[indexPath.section]]objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [KISDictionaryHaveKey(dic, @"last") stringByAppendingString:KISDictionaryHaveKey(dic, @"first")];
    cell.detailTextLabel.text = KISDictionaryHaveKey(dic, @"telphone");
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableDictionary *dic = [[addressBookDic objectForKey:keysArr[indexPath.section]]objectAtIndex:indexPath.row];
    [self showMessageViewWithPhotoNum:KISDictionaryHaveKey(dic, @"telphone")];
//    [[UIApplication sharedApplication]openURL:smsUrl];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return keysArr[section];
}


#pragma mark ---发送短信
- (void)showMessageViewWithPhotoNum:(NSString *)num
{
    
    if( [MFMessageComposeViewController canSendText] ){
        
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc]init]; //autorelease];
        
        controller.recipients = [NSArray arrayWithObject:num];
        controller.body = @"测试发短信";
        controller.messageComposeDelegate = self;
        
        [self presentViewController:controller animated:YES completion:^{
            
        }];
        
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"测试短信"];//修改短信界面标题
    }else{
        
        [self alertWithTitle:@"提示信息" msg:@"设备没有短信功能"];
    }
}


//MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    
    [controller dismissViewControllerAnimated:NO completion:^{
        
    }];//关键的一句   不能为YES
    
    switch ( result ) {
        case MessageComposeResultCancelled:
            [self alertWithTitle:@"提示信息" msg:@"发送取消"];
            break;
        case MessageComposeResultFailed:// send failed
            [self alertWithTitle:@"提示信息" msg:@"发送失败"];
            break;
        case MessageComposeResultSent:
            [self alertWithTitle:@"提示信息" msg:@"发送成功"];
            break;
        default:
            break;
    }
}

- (void) alertWithTitle:(NSString *)title msg:(NSString *)msg {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"确定", nil];
    [alert show];
}


#pragma mark ---searchBar
//取消搜索或者改变搜索条件
-(void)resetSearch
{//重置搜索
    addressBookDic = [[ZCAddressBook shareControl]getPersonInfo];
    keysArr = [NSMutableArray arrayWithArray:[[ZCAddressBook shareControl]sortMethod]];
}
-(void)handleSearchForTerm:(NSString *)searchTerm
{//处理搜索
    NSMutableArray *sectionToRemove=[NSMutableArray new];
    //分组待删除列表
    [self resetSearch];
    //先重置
    for(NSString *key in keysArr)
    {//循环读取所有的数组
        NSMutableArray *array=[addressBookDic valueForKey:key];
        NSMutableArray *toRemove=[NSMutableArray new];
        //待删除列表
        for(NSDictionary *dic in array)
        {//数组内的元素循环对比
            NSString *name = [[dic objectForKey:@"last"]stringByAppendingString:[dic objectForKey:@"first"]];
            
            
            if([name rangeOfString:searchTerm options:NSCaseInsensitiveSearch].location==NSNotFound)
            {
                //rangeOfString方法是返回NSRange对象(包含位置索引和长度信息)
                //NSCaseInsensitiveSearch是忽略大小写
                //这里的代码会在name中找不到searchTerm时执行
                [toRemove addObject:name];
                //找不到，把name添加到待删除列表
            }
        }
        if ([array count]==[toRemove count]) {
            [sectionToRemove addObject:key];
            //如果待删除的总数和数组元素总数相同，把该分组的key加入待删除列表，即不显示该分组
        }
        [array removeObjectsInArray:toRemove];
        //删除数组待删除元素
    }
    [keysArr removeObjectsInArray:sectionToRemove];
    //能过待删除的key数组删除数组
    [myTabelView reloadData];
    //重载数据
    
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{//TableView的项被选择前触发
    [mSearchBar resignFirstResponder];
    //搜索条释放焦点，隐藏软键盘
    return indexPath;
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{//按软键盘右下角的搜索按钮时触发
    NSString *searchTerm=[searchBar text];
    //读取被输入的关键字
    [self handleSearchForTerm:searchTerm];
    //根据关键字，进行处理
    [mSearchBar resignFirstResponder];
    //隐藏软键盘
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{//搜索条输入文字修改时触发
    if([searchText length]==0)
    {//如果无文字输入
        [self resetSearch];
        [myTabelView reloadData];
        return;
    }
    
    [self handleSearchForTerm:searchText];
    //有文字输入就把关键字传给handleSearchForTerm处理
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{//取消按钮被按下时触发
    [self resetSearch];
    //重置
    searchBar.text=@"";
    //输入框清空
    [myTabelView reloadData];
    [mSearchBar resignFirstResponder];
    //重新载入数据，隐藏软键盘
    
}
- (void)dealloc
{
    myTabelView.delegate = nil;
    myTabelView.dataSource = nil;
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

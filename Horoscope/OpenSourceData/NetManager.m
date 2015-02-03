//
//  NetManager.m
//  Horoscope
//
//  Created by Satellite on 14/12/18.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import "NetManager.h"

@implementation NetManager

+ (NetManager *)sharedManager
{
    static NetManager *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}


-(void)PostNetWithString:(NSString *)str
{
    NSURL *url=[NSURL URLWithString:str];
    NSMutableURLRequest *request=[NSMutableURLRequest  requestWithURL:url];
    request.timeoutInterval=5.0;
    
    NSURLConnection *conn=[NSURLConnection connectionWithRequest:request delegate:self];
    
    [conn start];
 
}

#pragma mark- NSURLConnectionDataDelegate代理方法
/*
 *当接收到服务器的响应（连通了服务器）时会调用
 */
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"接收到服务器的响应");
    //初始化数据
    self.responseData=[NSMutableData data];
}

/*
 *当接收到服务器的数据时会调用（可能会被调用多次，每次只传递部分数据）
 */
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"接收到服务器的数据");
    //拼接数据
    [self.responseData appendData:data];
    NSLog(@"%d---%@--",self.responseData.length,[NSThread currentThread]);
}

/*
 *当服务器的数据加载完毕时就会调用
 */
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"服务器的数据加载完毕");
    //隐藏HUD
    
    //处理服务器返回的所有数据
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:nil];
    
      NSLog(@"%d---%@--",self.responseData.length,dict);
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"getInfoFromNet" object:nil userInfo:dict];
    
}
/*
 *请求错误（失败）的时候调用（请求超时\断网\没有网\，一般指客户端错误）
 */
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //     NSLog(@"请求错误");
    //隐藏HUD
}
@end

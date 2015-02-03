//
//  RequestTaskService.h
//  GameGroup
//
//  Created by Apple on 14-10-29.
//  Copyright (c) 2014年 Swallow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestTaskService : NSObject
@property(nonatomic, strong) NSMutableDictionary * classTasksDic;
@property(nonatomic, strong) NSMutableDictionary * oneTaskDic;
+ (RequestTaskService*)singleton;
-(void)addRequest:(NSString*)className RequestOperation:(AFHTTPRequestOperation*)requestOperation RequestOperationName:(NSString*)requestOperationName;
-(void)removeRequest:(NSString*)className RequestOperation:(AFHTTPRequestOperation*)requestOperation RequestOperationName:(NSString*)requestOperationName;
-(void)clearRequest:(NSString*)className;
-(void)clearOneRequest:(NSString*)className;
@end

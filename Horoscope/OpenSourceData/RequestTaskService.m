//
//  RequestTaskService.m
//  GameGroup
//
//  Created by Apple on 14-10-29.
//  Copyright (c) 2014年 Swallow. All rights reserved.
//

#import "RequestTaskService.h"
static RequestTaskService * requestTaskService = NULL;

@implementation RequestTaskService
-(id)init
{
    self = [super init];
    if (self) {
        self.classTasksDic = [NSMutableDictionary dictionary];
        self.oneTaskDic = [NSMutableDictionary dictionary];
    }
    return self;
}
+ (RequestTaskService*)singleton
{
    @synchronized(self)
    {
        if (requestTaskService == nil)
        {
            requestTaskService = [[self alloc] init];
        }
    }
    return requestTaskService;
}

-(void)addRequest:(NSString*)className RequestOperation:(AFHTTPRequestOperation*)requestOperation RequestOperationName:(NSString*)requestOperationName{
    NSLog(@"111111------添加请求-->>%@-->>%@--->>%@",className,requestOperationName,requestOperation);
    NSMutableArray * classTasKarray = [self.classTasksDic objectForKey:className];
    if (!classTasKarray) {
        classTasKarray = [NSMutableArray array];
    }
    [classTasKarray addObject:requestOperation];
    [self.classTasksDic setObject:classTasKarray forKey:className];
    [self.oneTaskDic setObject:requestOperation forKey:requestOperationName];
}
-(void)removeRequest:(NSString*)className RequestOperation:(AFHTTPRequestOperation*)requestOperation RequestOperationName:(NSString*)requestOperationName{
    NSLog(@"111111------清除请求-->>%@-->>%@--->>%@",className,requestOperationName,requestOperation);
    NSMutableArray * classTasKarray = [self.classTasksDic objectForKey:className];
    if (classTasKarray&&[classTasKarray isKindOfClass:[NSArray class]]&&classTasKarray.count>0) {
        [classTasKarray removeObject:requestOperation];
        [self.classTasksDic setObject:classTasKarray forKey:className];
    }
    [self.oneTaskDic removeObjectForKey:requestOperationName];
}

-(void)clearRequest:(NSString*)className{
    NSMutableArray * classTasKarray = [self.classTasksDic objectForKey:className];
    NSMutableArray * tempClassTaskArray = [classTasKarray mutableCopy];
    if (tempClassTaskArray&&[tempClassTaskArray isKindOfClass:[NSArray class]]&&tempClassTaskArray.count>0) {
        for (AFHTTPRequestOperation * operation in tempClassTaskArray) {
            if (operation) {
                NSLog(@"111111------取消请求-->>%@--->>%@",className,operation);
                [self removeRequest:className RequestOperation:operation RequestOperationName:operation.operationName];
                if (operation.isExecuting) {
                    [operation cancel];
                }
            }
        }
    }
}

-(void)clearOneRequest:(NSString*)className{
    AFHTTPRequestOperation * operation = [self.oneTaskDic objectForKey:className];
    if (operation) {
        [operation cancel];
        [self removeRequest:className RequestOperation:operation RequestOperationName:operation.operationName];
    }
}



@end

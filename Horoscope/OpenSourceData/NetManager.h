//
//  NetManager.h
//  Horoscope
//
//  Created by Satellite on 14/12/18.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetManager : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate,NSURLConnectionDownloadDelegate>
+ (NetManager *)sharedManager;
@property(nonatomic,strong)NSMutableData *responseData;
-(void)PostNetWithString:(NSString *)str;
@end

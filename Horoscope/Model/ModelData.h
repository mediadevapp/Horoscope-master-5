//
//  ModelData.h
//  Horoscope
//
//  Created by SAT on 14/12/23.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelData : NSObject



+ (NSURLSessionDataTask *)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block;


@end

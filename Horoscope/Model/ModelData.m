//
//  ModelData.m
//  Horoscope
//
//  Created by SAT on 14/12/23.
//  Copyright (c) 2014年 施傲天. All rights reserved.
//

#import "ModelData.h"
#import "AFAppDotNetAPIClient.h"

@implementation ModelData

#pragma mark -

+ (NSURLSessionDataTask *)globalTimelineModelsWithBlock:(void (^)(NSArray *posts, NSError *error))block {
    return [[AFAppDotNetAPIClient sharedClient] GET:@"stream/0/posts/stream/global" parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSArray *postsFromResponse = [JSON valueForKeyPath:@"data"];
        NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        for (NSDictionary *attributes in postsFromResponse) {
            
            //            ModelData *post = [[Post alloc] initWithAttributes:attributes];
//            [mutablePosts addObject:post];
        }
        
        if (block) {
            block([NSArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
}


@end

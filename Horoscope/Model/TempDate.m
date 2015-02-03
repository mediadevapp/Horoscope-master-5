//
//  TempDate.m
//  Horoscope
//
//  Created by Satellite on 15/1/7.
//
//

#import "TempDate.h"

@implementation TempDate
#pragma mark - 联网默认字段
+(NSString*) uuid
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    CFRelease(uuid_ref);
    
    NSString *uuid =  [[NSString  alloc]initWithCString:CFStringGetCStringPtr(uuid_string_ref, 0) encoding:NSUTF8StringEncoding];
    uuid = [uuid stringByReplacingOccurrencesOfString:@"-"withString:@""];
    CFRelease(uuid_string_ref);
    
    return uuid;
}

@end

//
//  UserCache.h
//  Horoscope
//
//  Created by SAT on 15/1/12.
//
//

#import <Foundation/Foundation.h>

@interface UserCache : NSObject

//+ (UserCache*) sharedInstance ;
- (BOOL)hasObjectForKey:(id)key;
+ (UserCache*) sharedInstance;
- (id)objectForKey:(NSString *)key;
- (void)setObject:(id)value forKey:(NSString *)key;
- (void)removeObjectForKey:(NSString *)key;
- (void)removeAllObjects;
- (id)objectForKeyedSubscript:(id)key;

- (void)setObject:(id)obj forKeyedSubscript:(id)key;

@end

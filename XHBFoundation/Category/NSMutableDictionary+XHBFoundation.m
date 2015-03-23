
//
//  NSMutableDictionary+XHBFoundation.m
//  XHBFoundation
//
//  Created by weqia on 15-1-13.
//  Copyright (c) 2015 year xhb. All rights reserved.
//

#import "NSMutableDictionary+XHBFoundation.h"
#import <objc/runtime.h>

const NSString * Lock;
@implementation NSMutableDictionary (XHBFoundation)

-(id)threadSafeObjectForKey:(id)aKey
{
    if ([NSThread isMainThread]) {
        return [self objectForKey:aKey];
    }else{
        __block id value;
        dispatch_sync(dispatch_get_main_queue(), ^{
            value=[self objectForKey:aKey];
        });
        return value;
    }
}
-(void)threadSafeSetObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if ([NSThread isMainThread]) {
        [self setObject:anObject forKey:aKey];
    }else{
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self setObject:anObject forKey:aKey];
        });
    }
}
-(void)threadSafeRemoveObjectForKey:(id<NSCopying>)aKey
{
    if ([NSThread isMainThread]) {
        [self removeObjectForKey:aKey];
    }else{
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self removeObjectForKey:aKey];
        });
    }
}


@end

//
//  NSGCDThread.m
//  DoctorClient
//
//  Created by weqia on 14-4-27.
//  Copyright (c) 2014year xhb. All rights reserved.
//

#import "NSGCDThread.h"

@implementation NSGCDThread
+(void)dispatchAsync:(void(^)())block
{
    [self dispatchAsync:block complete:nil];
}
+(void)dispatchAsync:(void(^)())block complete:(void(^)())complete
{
    if ([NSThread isMainThread]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (block) {
                block();
                if (complete) {
                    complete();
                }
            }
        });
    }else{
        if (block) {
            block();
            if (complete) {
                complete();
            }
        }
    }
}

//dispatch_sync(queue, block) 同步
+(void)dispatchSync:(void(^)())block
{
    [self dispatchSync:block complete:nil];
}
+(void)dispatchSync:(void(^)())block complete:(void(^)())complete
{
    if ([NSThread isMainThread]) {
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (block) {
                block();
                if (complete) {
                    complete();
                }
            }
        });
    }else{
        if (block) {
            block();
            if (complete) {
                complete();
            }
        }
    }
}
+(void)dispatchSyncInMailThread:(void(^)())block
{
    if ([NSThread isMainThread]) {
        if (block) {
            block();
        }
    }else{
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}
+(dispatch_queue_t)shareConcurrentQueue
{
    static dispatch_queue_t queue=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue=dispatch_queue_create("GlobalShareConcurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    });
    return queue;
}


@end

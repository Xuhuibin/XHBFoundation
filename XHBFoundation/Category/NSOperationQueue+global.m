//
//  NSOperationQueue+global.m
//  wq8
//
//  Created by weqia on 13-11-26.
//  Copyright (c) 2013year Weqia. All rights reserved.
//

#import "NSOperationQueue+global.h"
#import "XHBPrecompile.h"
#import <UIKit/UIKit.h>

@implementation NSOperationQueue (global)
+(id)uploadQueue
{
    static NSOperationQueue * uploadQueue=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        uploadQueue=[[NSOperationQueue alloc]init];
        uploadQueue.maxConcurrentOperationCount=1;
    });
    return uploadQueue;
}
+(id)imageQueue
{
    static NSOperationQueue * imageQueue=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageQueue=[[NSOperationQueue alloc]init];
        imageQueue.maxConcurrentOperationCount=4;
    });
    return imageQueue;
}
+(id)downLoadQueue
{
    static NSOperationQueue * downLoadQueue=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downLoadQueue=[[NSOperationQueue alloc]init];
        downLoadQueue.maxConcurrentOperationCount=2;
    });
    return downLoadQueue;
}

+(id)dboprationQueue;
{
    static NSOperationQueue * operationQueue=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        operationQueue=[[NSOperationQueue alloc]init];
        operationQueue.maxConcurrentOperationCount=1;
        if (IOS_VERSION>=8.0) {
            operationQueue.qualityOfService=NSQualityOfServiceBackground;
        }
    });
    return operationQueue; 
}
+(id)baseQueue
{
    static NSOperationQueue * operationQueue=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        operationQueue=[[NSOperationQueue alloc]init];
        operationQueue.maxConcurrentOperationCount=1;
    });
    return operationQueue;
}

@end

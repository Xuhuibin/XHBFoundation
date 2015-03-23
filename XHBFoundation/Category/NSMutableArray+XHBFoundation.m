//
//  NSMutableArray+XHBFoundation.m
//  Weqia
//
//  Created by weqia on 14-10-30.
//  Copyright (c) 2014year xhb. All rights reserved.
//

#import "NSMutableArray+XHBFoundation.h"
#import "NSArray+XHBFoundation.h"


@implementation NSMutableArray (XHBFoundation)


-(void)removeObjectsWithDescriptors:(NSArray*)despriptors
{
    NSArray * subarray=[self subarrayWithDescriptors:despriptors];
    if (subarray.count>0) {
        for (id object in subarray) {
            [self removeObject:object];
        }
    }
}

-(void)sortWithXHBSortDescriptors:(NSArray*)despriptors
{
    [self sortUsingFunction:&customCompare context:(__bridge void *)(despriptors)];
}


@end

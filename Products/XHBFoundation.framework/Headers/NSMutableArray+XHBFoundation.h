//
//  NSMutableArray+XHBFoundation.h
//  Weqia
//
//  Created by weqia on 14-10-30.
//  Copyright (c) 2014年 xhb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (XHBFoundation)

-(void)removeObjectsWithDescriptors:(NSArray*)despriptors;

-(void)sortWithXHBSortDescriptors:(NSArray*)despriptors;

@end

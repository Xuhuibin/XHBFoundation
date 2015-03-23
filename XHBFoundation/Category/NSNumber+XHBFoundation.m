

//
//  NSNumber+XHBFoundation.m
//  XHBFoundation
//
//  Created by weqia on 15-1-20.
//  Copyright (c) 2015 year xhb. All rights reserved.
//

#import "NSNumber+XHBFoundation.h"

@implementation NSNumber (XHBFoundation)
-(NSInteger)length
{
    return [NSString stringWithFormat:@"%@",self].length;
}
@end

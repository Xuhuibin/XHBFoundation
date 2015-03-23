//
//  JSONKit+XHBFoundation.m
//  Weqia
//
//  Created by weqia on 14-11-11.
//  Copyright (c) 2014year xhb. All rights reserved.
//

#import "JSONKit+XHBFoundation.h"
#import <XHBFoundation/JSONKit.h>
@implementation NSString (XHBFoundation)

+(NSArray*)arrayObjects:(NSString*)json cls:(Class)cls
{
    if (cls==nil) {
        return nil;
    }
    NSArray * array;
    if ([json isKindOfClass:[NSString class]]) {
        array=[json objectFromJSONString];
    }else if ([json isKindOfClass:[NSArray class]]){
        array=(NSArray*)json;
    }
    if ([array isKindOfClass:[NSArray class]]) {
        NSMutableArray * datas=[NSMutableArray new];
        for (NSDictionary*dic in array) {
            if ([dic isKindOfClass:[NSDictionary class]]) {
                [datas addObject:[[cls alloc]initWithDictionary:dic]];
            }
        }
        return datas;
    }else{
        return nil;
    }
}
+(id)singleObject:(NSString*)json cls:(Class)cls
{
    if (cls==nil) {
        return nil;
    }
    NSDictionary * dic;
    if ([json isKindOfClass:[NSString class]]) {
        dic=[json objectFromJSONString];
    }else if([json isKindOfClass:[NSDictionary class]]){
        dic=(NSDictionary*)json;
    }
    if ([dic isKindOfClass:[NSDictionary class]]) {
        return [[cls alloc]initWithDictionary:dic];
    }else{
        return nil;
    }
}

@end

//
//  NSArray+XHBFoundation.m
//  Weqia
//
//  Created by weqia on 14-10-30.
//  Copyright (c) 2014year xhb. All rights reserved.
//

#import "NSArray+XHBFoundation.h"

@implementation XHBSortDescriptor

+(instancetype)sortDescriptor:(NSString*)key  ascending:(BOOL)ascending;
{
    XHBSortDescriptor * descriptor=[[XHBSortDescriptor alloc]init];
    descriptor.key=key;
    descriptor.ascending=ascending;
    return descriptor;
}

@end


@implementation XHBSelectDescriptor

+(instancetype)selectDescriptor:(NSString*)key value:(id)value
{
    XHBSelectDescriptor * descriptor=[[self alloc]init];
    descriptor.key=key;
    descriptor.value=value;
    return descriptor;
}
+(instancetype)selectDescriptor:(NSString*)key regular:(NSRegularExpression*)regular
{
    XHBSelectDescriptor * descriptor=[[self alloc]init];
    descriptor.key=key;
    descriptor.regular=regular;
    return descriptor;
}

@end


@implementation NSArray (XHBFoundation)

-(NSArray*)subarrayWithDescriptors:(NSArray*)despriptors
{
    if (despriptors.count>0) {
        NSMutableArray  * array=[NSMutableArray array];
        for (id object in self) {
            BOOL match=YES;
            for (XHBSelectDescriptor * descriptor in despriptors) {
                if (descriptor.key!=nil&&descriptor.value!=nil) {
                    id value=[object valueForKey:descriptor.key];
                    if (![value isEqual:descriptor.value]) {
                        match=NO;
                        break;
                    }
                }else if(descriptor.key!=nil&&descriptor.regular!=nil){
                    NSString* value=[object valueForKey:descriptor.key];
                    if ([value isKindOfClass:[NSString class]]) {
                        if ([descriptor.regular numberOfMatchesInString:value options:NSMatchingReportCompletion range:NSMakeRange(0, 0)]==0) {
                            match=NO;
                            break;
                        }
                    }else{
                        return nil;
                    }
                }else{
                    return nil;
                }
            }
            if (match) {
                [array addObject:object];
            }
        }
        return array;
    }else{
        return nil;
    }
}

-(id)objectWithDescriptors:(NSArray*)despriptors
{
    if (despriptors.count>0) {
        for (id object in self) {
            BOOL match=YES;
            for (XHBSelectDescriptor * descriptor in despriptors) {
                if (descriptor.key!=nil) {
                    id value=[object valueForKey:descriptor.key];
                    if (value==nil) {
                        if (descriptor.value!=nil) {
                            match=NO;
                            break;
                        }
                    }else{
                        if (descriptor.value!=nil) {
                            if (![value isEqual:descriptor.value]) {
                                match=NO;
                                break;
                            }
                        }else{
                            match=NO;
                            break;
                        }
                    }
                }else{
                    return nil;
                }
            }
            if (match) {
                return object;
            }
        }
    }
    return nil;
}

-(id)objectWithDescriptors:(NSArray *)despriptors sortXHBDescriptors:(NSArray*)sortDespriptors
{
    NSArray * datas=[self subarrayWithDescriptors:despriptors];
    if (despriptors) {
        NSArray * sortDatas=[datas sortedArrayWithXHBSortDescriptors:sortDespriptors];
        if (sortDatas.count>0) {
            return [sortDatas objectAtIndex:0];
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}


-(NSArray*)sortedArrayWithXHBSortDescriptors:(NSArray*)despriptors
{
    return [self  sortedArrayUsingFunction:&customCompare context:(__bridge void *)(despriptors)];
}


-(NSString*)arrayStringSeparateByDotForKey:(NSString*)key
{
    NSMutableString * string=[NSMutableString new];
    BOOL first=YES;
    for (id object in self) {
        NSString * value=[object valueForKey:key];
        if (value) {
            if (first) {
                first=NO;
            }else{
                [string appendString:@","];
            }
            [string appendFormat:@"%@",value];
        }
    }
    return string;
}


@end


NSInteger customCompare(id obj1, id obj2, void* context){
    NSArray* despriptors=(__bridge NSArray *)(context);
    
    NSComparisonResult result=NSOrderedSame;
    for (NSInteger index=0; index<despriptors.count; index++) {
        XHBSortDescriptor * descriptor=[despriptors objectAtIndex:index];
        if (descriptor.key==nil) {
            return NSOrderedSame;
        }
        id value1=[obj1 valueForKey:descriptor.key];
        id value2=[obj2 valueForKey:descriptor.key];
        
        if (value1!=nil&&value2!=nil) {
            if ([value1 isKindOfClass:[NSNumber class]]&&[value2 isKindOfClass:[NSNumber class]]){
                if (descriptor.ascending) {
                    result= [value1 compare:value2];
                }else{
                    result= [value2 compare:value1];
                }
            }else if([value1 isKindOfClass:[NSString class]]&&[value2 isKindOfClass:[NSString class]]){
                if (descriptor.ascending) {
                    result= [value1 compare:value2 options:NSNumericSearch];
                }else{
                    result= [value2 compare:value1 options:NSNumericSearch];
                }
            }else if ([value2 isKindOfClass:[NSString class]]&&[value1 isKindOfClass:[NSNumber class]]){
                value2=[NSNumber numberWithLongLong:[((NSString*)value2) integerValue]];
                if (descriptor.ascending) {
                    result= [value1 compare:value2];
                }else{
                    result= [value2 compare:value1];
                }
            }else if ([value1 isKindOfClass:[NSString class]]&&[value2 isKindOfClass:[NSNumber class]]){
                value1=[NSNumber numberWithLongLong:[((NSString*)value1) integerValue]];
                if (descriptor.ascending) {
                    result= [value1 compare:value2];
                }else{
                    result= [value2 compare:value1];
                }
            }else{
                result= NSOrderedSame;
            }
        }else{
            result= NSOrderedSame;
        }
        if (result!=NSOrderedSame) {
            return result;
        }
    }
    return  NSOrderedSame;
}

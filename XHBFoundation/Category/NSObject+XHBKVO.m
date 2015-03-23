//
//  NSObject+XHBKVO.m
//  XHBFoundation
//
//  Created by weqia on 14-9-30.
//  Copyright (c) 2014year xhb. All rights reserved.
//
#import <objc/runtime.h>
#import "NSObject+XHBKVO.h"
#import "JastorRuntimeHelper.h"
#import "NSMutableDictionary+XHBFoundation.h"
@implementation XHBObjectPropertyCallback
@synthesize propertyCallback,propertyKeyPath;


@end


const NSString * XHBObjectPropertyCallbacks=@"XHBObjectPropertyCallbacks";

@implementation NSObject (XHBKVO)

-(void)addObservePropertForKeyPath:(NSString *)keyPath callback:(void (^)(BOOL Immediately))callback
{
    if (keyPath!=nil&&callback!=nil&&[self hasProperty:keyPath]) {
        callback(YES);
        [self addPropertyCallback:keyPath callback:callback];
    }
}
/**
 *  判断某个对象是否拥有某个属性（或者某个成员对象拥有该属性（迭代））
 *
 *  @param keyPath 某个属性路径
 */
-(BOOL)hasProperty:(NSString*)keyPath
{
    if (keyPath!=nil) {
        NSRange range=[keyPath rangeOfString:@"."];
        if (range.location==NSNotFound) {
            NSArray * propertys=[JastorRuntimeHelper propertyNames:[self class]];
            for (NSString * propertyName in propertys) {
                if ([propertyName isEqualToString:keyPath]) {
                    return YES;
                }
            }
            return NO;
        }else{
            NSString * propertyLevelOne=[keyPath substringToIndex:range.location];
            BOOL has=NO;
            NSArray * propertys=[JastorRuntimeHelper propertyNames:[self class]];
            for (NSString * propertyName in propertys) {
                if ([propertyName isEqualToString:keyPath]) {
                    has=YES;
                }
            }
            if (has) {
                NSString * otherPropertys=[keyPath substringFromIndex:range.location+1];
                if (otherPropertys!=nil) {
                    NSObject * value=[self valueForKey:propertyLevelOne];
                    if (value) {
                        return [value hasProperty:otherPropertys];
                    }else{
                        return NO;
                    }
                }else{
                    return NO;
                }
            }else{
                return NO;
            }
        }
    }else{
        return NO;
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (keyPath) {
        XHBObjectPropertyCallback * callback=[self propertyCallback:keyPath];
        if (callback) {
            callback.propertyCallback(NO);
        }
    }
}

-(XHBObjectPropertyCallback*)propertyCallback:(NSString*)keyPath;
{
    NSMutableDictionary * callbacks= objc_getAssociatedObject(self, &XHBObjectPropertyCallbacks);
    if (callbacks) {
        return [callbacks threadSafeObjectForKey:keyPath];
    }else{
        return nil;
    }
}
-(void)addPropertyCallback:(NSString*)keyPath callback:(void(^)(BOOL Immediately))callback
{
    if (keyPath!=nil&&callback!=nil) {
        NSMutableDictionary * callbacks= objc_getAssociatedObject(self, &XHBObjectPropertyCallbacks);
        if (callbacks==nil) {
            callbacks=[NSMutableDictionary dictionary];
            objc_setAssociatedObject(self, &XHBObjectPropertyCallbacks, callbacks, OBJC_ASSOCIATION_RETAIN);
        }
        
        XHBObjectPropertyCallback * propertyCallback=[callbacks threadSafeObjectForKey:keyPath];
        if (propertyCallback==nil) {
            [self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionInitial context:nil];
            propertyCallback=[[XHBObjectPropertyCallback alloc]init];
        }
        propertyCallback.propertyCallback=[callback copy];
        propertyCallback.propertyKeyPath=keyPath;
        [callbacks threadSafeSetObject:propertyCallback forKey:keyPath];
    }
}

-(void)removeAllPropertyCallbacks
{
    NSDictionary * dic=objc_getAssociatedObject(self, &XHBObjectPropertyCallbacks);
    if (dic) {
        NSArray * keys=[dic allKeys];
        for (NSString * key  in keys) {
            [self removeObserver:self forKeyPath:key];
        }
    }
    objc_setAssociatedObject(self, &XHBObjectPropertyCallbacks, nil, OBJC_ASSOCIATION_RETAIN);
}

-(void)removeObserveForKeyPath:(NSString*)keyPath
{
    if (keyPath!=nil) {
        NSMutableDictionary * dic=objc_getAssociatedObject(self, &XHBObjectPropertyCallbacks);
        if (dic) {
            NSArray * keys=[dic allKeys];
            for (NSString * key  in keys) {
                if ([keyPath isEqualToString:key]) {
                    [self removeObserver:self forKeyPath:keyPath];
                    break;
                }
            }
        }
        [dic threadSafeRemoveObjectForKey:keyPath];
    }
}


@end

//
//  Jastor.m
//  XHBFoundation
//
//  Created by weqia on 14-9-28.
//  Copyright (c) 2014year xhb. All rights reserved.
//

#import "Jastor.h"
#import "JastorRuntimeHelper.h"
#import <objc/runtime.h>

@implementation Jastor
static NSString *idPropertyName = @"idProperty";
static NSString *idPropertyNameOnObject = @"objectId";

Class nsDictionaryClass;
Class nsArrayClass;

+ (id)objectFromDictionary:(NSDictionary*)dictionary {
    id item = [[self alloc] initWithDictionary:dictionary];
    return item;
}


- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (!nsDictionaryClass) nsDictionaryClass = [NSDictionary class];
    if (!nsArrayClass) nsArrayClass = [NSArray class];
    if ((self = [self init])) {
        for (NSString *key in [JastorRuntimeHelper propertyNames:[self class]]) {
            
            id value = [dictionary valueForKey:key];
            
            if (value == [NSNull null] || value == nil) {
                continue;
            }
            if ([JastorRuntimeHelper isPropertyReadOnly:[self class] propertyName:key]) {
                continue;
            }
            // handle all others
            [self safeSetValue:value forKey:key];
        }
        id objectIdValue;
        if ((objectIdValue = [dictionary objectForKey:idPropertyName]) && objectIdValue != [NSNull null]) {
            if (![objectIdValue isKindOfClass:[NSString class]]) {
                objectIdValue = [NSString stringWithFormat:@"%@", objectIdValue];
            }
            [self safeSetValue:objectIdValue forKey:idPropertyNameOnObject];
        }
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder*)encoder {
    for (NSString *key in [JastorRuntimeHelper propertyNames:[self class]]) {
        [encoder encodeObject:[self valueForKey:key] forKey:key];
    }
}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [self init])) {
        [self safeSetValue:[decoder decodeObjectForKey:idPropertyNameOnObject] forKey:idPropertyNameOnObject];
        
        for (NSString *key in [JastorRuntimeHelper propertyNames:[self class]]) {
            if ([JastorRuntimeHelper isPropertyReadOnly:[self class] propertyName:key]) {
                continue;
            }
            id value = [decoder decodeObjectForKey:key];
            if (value != [NSNull null] && value != nil) {
                [self safeSetValue:value forKey:key];
            }
        }
    }
    return self;
}

- (NSMutableDictionary *)toDictionary {
    return [self toDictionaryWithProperty:nil];
}

-(NSMutableDictionary*)toDictionaryWithProperty:(BOOL(^)(NSString * propertyName))property
{
    if ([self class]==[NSObject class]) {
        return [NSMutableDictionary dictionary];
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [[JastorRuntimeHelper propertyNames:[self class]] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (obj!=nil) {
            NSString *key=obj;
            
            if(property){
                if(!property(key))
                    return;
            }
#if __IPHONE_OS_VERSION_MAX_ALLOWED>__IPHONE_7_1    // 针对 IOS8 上的一个BUG， 排除掉 NSObject 的 四个属性。
            if ([key isEqualToString:@"description"]) {
                return;
            }else if([key isEqualToString:@"hash"]){
                return;
            }else if([key isEqualToString:@"superclass"]){
                return;
            }else if([key isEqualToString:@"debugDescription"]){
                return;
            }
#endif
            id value = [self valueForKey:key];
            if (value && [value respondsToSelector:@selector(toDictionary)]) {
                [dic setObject:[(Jastor*)value toDictionary] forKey:key];
            } else if (value && [value isKindOfClass:[NSArray class]] && ((NSArray*)value).count > 0) {
                NSMutableArray *internalItems = [NSMutableArray array];
                for (id item in value) {
                    if ([item respondsToSelector:@selector(toDictionary)]) {
                        [internalItems addObject:[item toDictionary]];
                    }else{
                        [internalItems addObject:item];
                    }
                }
                [dic setObject:internalItems forKey:key];
            }else if([value isKindOfClass:[NSDictionary class]]&&value!=nil){
                NSArray * keys=[value allKeys];
                NSMutableDictionary * internalItems=[NSMutableDictionary dictionary];
                for(NSString *key in keys){
                    id Value=[((NSDictionary*)value) objectForKey:key];
                    if([Value respondsToSelector:@selector(toDictionary)]){
                        [internalItems setObject:[Value toDictionary] forKey:key];
                    }else{
                        [internalItems setObject:Value forKey:key];
                    }
                }
                [dic setObject:internalItems forKey:key];
            }
            else if (value != nil) {
                [dic setObject:value forKey:key];
            }
        }
    }];
    return dic;
}
-(void)safeSetValue:(id)value forKey:(NSString *)key
{
    Class  classType=[JastorRuntimeHelper propertyClassForPropertyName:key ofClass:[self class]];
    if (classType!=nil) {
        if (![value isKindOfClass:classType]) {
            value=[self value:value ConvertToClass:classType];
            [super setValue:value forKey:key];
        }else{
            [super setValue:value forKey:key];
        }
    }else{
        [super setValue:value forKey:key];
    }
}
-(id)value:(id)value ConvertToClass:(Class)classType
{
    //  从 NSNumber 类型 转换到 NSString 类型
    if ([value isKindOfClass:[NSNumber class]]&&[classType isSubclassOfClass:[NSString class]]) {
        return [NSString stringWithFormat:@"%@",value];
        
    }// 从 NSString 类型 转换到 NSNumber 类型
    else if ([value isKindOfClass:[NSString class]]&&[classType isSubclassOfClass:[NSNumber class]]) {
        return [NSNumber numberWithDouble:((NSString*)value).doubleValue];
    }
    return value;
}


- (NSString *)description {
    NSMutableDictionary *dic = [self toDictionary];
    
    return [NSString stringWithFormat:@"#<%@: %@>", [self class], [dic description]];
}

@end

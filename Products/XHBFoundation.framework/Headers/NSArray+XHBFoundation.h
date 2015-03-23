//
//  NSArray+XHBFoundation.h
//  Weqia
//
//  Created by weqia on 14-10-30.
//  Copyright (c) 2014年 xhb. All rights reserved.
//





#import <Foundation/Foundation.h>

// 如果value 不为nil 首先匹配value

@interface XHBSelectDescriptor : NSObject
@property(nonatomic,strong)NSString * key;
@property(nonatomic,strong)id value;
@property(nonatomic,strong)NSRegularExpression* regular;

+(instancetype)selectDescriptor:(NSString*)key value:(id)vlaue;

+(instancetype)selectDescriptor:(NSString*)key regular:(NSRegularExpression*)regular;

@end


/**
 *  数组比较描述器（可以直接在 NSIntenger 与 NSString 之间进行比较）
 */
@interface XHBSortDescriptor : NSObject

@property(nonatomic,strong)NSString * key;
@property(nonatomic)BOOL ascending;

+(instancetype)sortDescriptor:(NSString*)key  ascending:(BOOL)ascending;

@end




@interface NSArray (XHBFoundation)

/**
 *  根据选择器组获取子数组
 *
 *  @param despriptors 选择器组
 *
 *  @return
 */
-(NSArray*)subarrayWithDescriptors:(NSArray*)despriptors;
/**
 *  根据选择器组获取某个元素
 *
 *  @param despriptors 选择器组
 *
 *  @return
 */
-(id)objectWithDescriptors:(NSArray*)despriptors;

/**
 *  根据自定义的 排序器 排序
 *
 *  @param despriptors
 *
 *  @return
 */
-(NSArray*)sortedArrayWithXHBSortDescriptors:(NSArray*)despriptors;

/**
 *  object1.key , object2.key , object3.key  ->>  key1,key2,key3
 *
 *  @param key
 *
 *  @return
 */
-(NSString*)arrayStringSeparateByDotForKey:(NSString*)key;


@end

NSInteger customCompare(id obj1, id obj2, void* context);

//
//  NSObject+XHBKVO.h
//  XHBFoundation
//
//  Created by weqia on 14-9-30.
//  Copyright (c) 2014year xhb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHBObjectPropertyCallback : NSObject
@property(nonatomic,strong) NSString * propertyKeyPath;
@property(nonatomic,copy)void(^propertyCallback)(BOOL Immediately);

@end


/**
 *  KVO 实现
 */

@interface NSObject (XHBKVO)
/**
 *  为某个属性路径添加观察行为 (添加之后，callback 会立即执行一遍座位校准)
 *
 *  @param key      属性路径
 *  @param callback 路径下属性发生改变时的回调
 */

-(void)addObservePropertForKeyPath:(NSString *)key callback:(void (^)(BOOL Immediately))callback;
/**
 *  移除所有观察者
 */
-(void)removeAllPropertyCallbacks;

/**
 *  移除特定观察者
 *
 *  @param keyPath 
 */
-(void)removeObserveForKeyPath:(NSString*)keyPath;

/**
 *  判断某个对象是否拥有某个属性（或者某个成员对象拥有该属性（迭代））
 *
 *  @param keyPath 某个属性路径
 */
-(BOOL)hasProperty:(NSString*)keyPath;

@end

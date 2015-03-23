//
//  XHBObjectStorageProtocol.h
//  XHBFoundation
//
//  Created by weqia on 15-1-29.
//  Copyright (c) 2015 year xhb. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  对象存储协议
 */

@protocol XHBObjectStorageKeyProtocol <NSObject>

// 格式化主键
-(NSString*)formatKey;

@end


@protocol XHBObjectStorageProtocol <NSObject>

// 保存到本地存储
-(void)saveToStorageForKey:(id<XHBObjectStorageKeyProtocol>)key;

// 从本地存储中加载
-(void)loadFromStorageForKey:(id<XHBObjectStorageKeyProtocol>)key;

// 清除本地存储
-(void)clearStorageForKey:(id<XHBObjectStorageKeyProtocol>)key;


@end

//
//  XHBCacheProtocol.h
//  Weqia
//
//  Created by weqia on 14-10-25.
//  Copyright (c) 2014年 xhb. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  缓存协议
 */
@protocol XHBCacheProtocol <NSObject>
/**
 *  是否存在制定key 的缓存
 *
 *  @param key 缓存数据Key
 *
 *  @return
 */
-(BOOL)cached:(NSString*)key;
/**
 *  从内存中获取指定数据
 *
 *  @param key 数据Key
 *
 *  @return
 */
-(id)memoryCachedObject:(NSString*)key;
/**
 *  从硬盘中获取制定数据
 *
 *  @param key 数据Key
 *
 *  @return
 */
-(id)diskCachedObject:(NSString*)key;
/**
 *  将数据存到硬盘中
 *
 *  @param object 数据
 *  @param key    数据Key
 *
 *  @return
 */

-(BOOL)storeToDiskCache:(id)object key:(NSString*)key;
/**
 *  将数据缓存到内存中
 *
 *  @param object 数据
 *  @param key    数据Key
 *
 *  @return 
 */
-(BOOL)storeToMemoryCache:(id)object key:(NSString*)key;

/**
 *  清空缓存
 */
-(void)clearCache;

@end

//
//  XHBFileURLConvertProtocol.h
//  XHBFoundationEdit
//
//  Created by weqia on 14-9-27.
//  Copyright (c) 2014年 xhb. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XHBFileProtocol;

////  URL 转换器协议

@protocol XHBFileURLConvertProtocol <NSObject>
/**
 *  将指定 文件key 转换成文件URL
 *
 *  @param key      文件Key
 *  @param complete 完成回调
 */
-(NSOperation*)converFileKeyToURL:(NSString*)key complete:(void(^)(NSURL* url,id<XHBFileProtocol>file))complete;


/**
 *  将指定 文件key 转换成文件URL (同步)
 *
 *  @param key 文件key
 *
 *  @return 文件URL
 */
-(NSURL*)converFileKeyToURL:(NSString*)key;

@end

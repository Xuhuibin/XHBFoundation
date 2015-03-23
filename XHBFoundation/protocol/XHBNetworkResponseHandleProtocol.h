//
//  XHBNetworkResponseHandleProtocol.h
//  Weqia
//
//  Created by weqia on 14-11-11.
//  Copyright (c) 2014year xhb. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XHBNetworkResponseParserProtocol;
/**
 *  网络响应处理协议
 */

@protocol XHBNetworkResponseHandleProtocol <NSObject>

/**
 *  处理响应结果
 *
 *  @param result 网络请求响应结果
 *
 *  @return  能够被处理，返回YES，否则，返回NO
 */
-(BOOL)handle:(id<XHBNetworkResponseParserProtocol>)result param:(id)param;

@end

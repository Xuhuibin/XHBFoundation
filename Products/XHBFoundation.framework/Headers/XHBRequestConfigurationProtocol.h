//
//  XHBRequestConfigurationProtocol.h
//  XHBFoundationEdit
//
//  Created by weqia on 14-9-28.
//  Copyright (c) 2014年 xhb. All rights reserved.
//

#import <Foundation/Foundation.h>

//  ASIHTTPRequest 配置协议

@protocol XHBRequestConfigurationProtocol <NSObject>
/**
 *  配置网络请求线程
 *
 *  @param param 参数
 *
 *  @return 请求线程
 */
-(NSOperation*)configuration:(id)param;

@end

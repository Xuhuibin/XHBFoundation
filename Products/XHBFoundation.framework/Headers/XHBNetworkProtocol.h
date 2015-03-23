//
//  XHBNetworkProtocol.h
//  XHBToolKit
//
//  Created by weqia on 14-6-5.
//  Copyright (c) 2014年 xhb. All rights reserved.
//

#import <Foundation/Foundation.h>

////   网络请求协议

@protocol XHBNetworkResponseParserProtocol;
@protocol XHBNetworkResponseHandleProtocol;
@protocol XHBRequestConfigurationProtocol;

@protocol XHBNetworkProtocol <NSObject>

@optional

/**
 *  下载获取内容
 *
 *  @param param         参数(可为任何对象)
 *  @param progressBlock receiveedTotalSize  已经接收到得数据的大小
 *  @param completeBlock 完成时的回调
 *  @param failedBlock   失败时的回调
 *
 *  @return 返回下载线程
 */
-(NSOperation*)downloadDataFromServer:(id)param  progressBlock:(void(^)(unsigned long long receiveedTotalSize,unsigned long long totalSize))progressBlock completeBlock:(void (^)(id<XHBNetworkResponseParserProtocol> result,NSData*responseData))completeBlock failedBlock:(void (^)(id<XHBNetworkResponseParserProtocol> result))failedBlock;

/**
 *  上传内容
 *
 *  @param param         参数(可为任何对象)
 *  @param completeBlock 完成时的回调
 *  @param failedBlock   失败时的回调
 *  @param startBlock    开始上传的回调
 *  @param progressBlock sendedTotalSize: 已经上传的大小
 *
 *  @return 返回上传线程
 */
-(NSOperation*)uploadDataToServer:(id)param completeBlock:(void(^)(id<XHBNetworkResponseParserProtocol> result))completeBlock failedBlock:(void(^)(id<XHBNetworkResponseParserProtocol> result))failedBlock startBlock:(void(^)())startBlock progressBlock:(void(^)(unsigned long long sendedTotalSize, unsigned long long total))progressBlock;

/**
 *  基本网络操作
 *
 *  @param param         参数(可为任何对象)
 *  @param completeBlock 完成回调
 *  @param failedBlock   失败回调
 *
 *  @return 返回操作线程
 */
-(NSOperation*)baseNetworkTask:(id)param completeBlock:(void (^)(id<XHBNetworkResponseParserProtocol> result))completeBlock failedBlock:(void (^)(id<XHBNetworkResponseParserProtocol> result))failedBlock;

/**
 *  基本网络操作 (重载)
 *
 *  @param param         参数(可为任何对象)
 *  @param completeBlock 完成回调
 *  @param failedBlock   失败回调
 *  @param configure     单独的配置器 (如果为空，则默认使用公共配置器)
 *
 *  @return 返回操作线程
 */
-(NSOperation*)baseNetworkTask:(id)param completeBlock:(void (^)(id<XHBNetworkResponseParserProtocol> result))completeBlock failedBlock:(void (^)(id<XHBNetworkResponseParserProtocol> result))failedBlock configure:(id<XHBRequestConfigurationProtocol>)configure;

/**
 *  基本网络操作 (同步)
 *
 *  @param param     参数
 *  @param configure 单独的配置器(如果为空，则默认使用公共配置器)
 *
 *  @return 请求得到的数据
 */
-(id<XHBNetworkResponseParserProtocol>)baseNetworkTaskSync:(id)param configure:(id<XHBRequestConfigurationProtocol>)configure;

/**
 *  添加请求成功返回的 响应处理器
 *
 *  @param handle 响应处理器
 */
-(void)addCompleteHandle:(id<XHBNetworkResponseHandleProtocol>)handle;
/**
 *  添加请求失败的 响应处理器
 *
 *  @param handle 响应处理器
 */
-(void)addFailedHandle:(id<XHBNetworkResponseHandleProtocol>)handle;



@end




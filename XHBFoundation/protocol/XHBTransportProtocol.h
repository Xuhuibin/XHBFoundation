//
//  XHBTransportProtocol.h
//  Weqia
//
//  Created by weqia on 14-11-3.
//  Copyright (c) 2014year xhb. All rights reserved.
//

#import <Foundation/Foundation.h>

#define XHBTransportStatuChangeNotification @"XHBTransportStatuChangeNotification"
#define XHBTransportProgressNotification @"XHBTransportProgressNotification"
/**
 *  传输过程协议
 */

typedef NS_ENUM(NSUInteger, XHBTransportStatus) {
    XHBTransportWait=0, // 等待传输
    XHBTransporting,   // 传输中
    XHBTransportFailed,  //传输失败
    XHBTransportFinish, // 传输成功
    XHBTransportPause, // 暂停传输
};

@protocol XHBTransportProtocol <NSObject>

@optional

@property(nonatomic)int transportId; //传输ID(实现该协议的所有对象的主键) (在所有实现该协议的对象里都应该是唯一的)

@property(nonatomic)long totalSize;  // 所需传输的总size

@property(nonatomic)XHBTransportStatus transportStatus; //传输状态

@property(nonatomic)float transportProgress; //传输进展

/**
 *  app 启动的时候对表中状态为正在上传的记录进行修正（改为传输失败）
 */
+(void)correctionLaunching;


-(void)setTransportStatusWithKVO:(XHBTransportStatus)transportStatus;

-(void)setTransportProgressWithKVO:(float)transportProgress;


@end

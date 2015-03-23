//
//  XHBFileProtocol.h
//  Weqia
//
//  Created by weqia on 14-10-28.
//  Copyright (c) 2014年 xhb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHBTransportProtocol.h"
/**
 *  文件协议
 */

typedef NS_ENUM(NSUInteger, XHBFileType) {
    XHBFileTypeImage=1,
    XHBFileTypeSound,
    XHBFileTypeVedio,
    XHBFileTypeOther,
};


@protocol XHBFileProtocol <XHBTransportProtocol>

@optional

-(NSString*)fileURL;
-(NSString*)fileName;
-(NSString*)fileMime;
-(XHBFileType)fileType;



-(int)vsTime; // 当为 视频或语音时的 视频或语音长度

-(float)picRadio; // 当为图片是 宽/长比例

-(NSString*)fileNameWithSuffix; // 完整的文件名称 （带后缀）

@end

//
//  XHBViewControllerToolProtocol.h
//  XHBToolKit
//
//  Created by weqia on 14-6-6.
//  Copyright (c) 2014年 xhb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 工具类协议


@protocol XHBViewControllerToolOwnerDelegate;
typedef void(^XHBToolCompleteCallback)(id completeObject,UIViewController*operatorController);
typedef void(^XHBToolInitCallback)(id initObject);

@protocol XHBViewControllerToolProtocol <NSObject>

@property(nonatomic,weak,readonly) UIViewController<XHBViewControllerToolOwnerDelegate> * viewController; //操作工具的viewController
@property(nonatomic,copy,readonly) XHBToolInitCallback initCallback; //初始化回调
@property(nonatomic,copy,readonly) XHBToolCompleteCallback completeCallback;  //完成回调


-(void)operate:(UIViewController<XHBViewControllerToolOwnerDelegate>*)viewController initCallback:(XHBToolInitCallback)initCallback completeCallback:(XHBToolCompleteCallback)completeCallback;

@end



@protocol XHBViewControllerToolOwnerDelegate <NSObject>

@property(nonatomic,strong) id<XHBViewControllerToolProtocol> controlTool;

@end
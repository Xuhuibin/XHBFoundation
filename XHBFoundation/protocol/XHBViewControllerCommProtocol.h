//
//  XHBViewControllerCommProtocol.h
//  XHBToolKit
//
//  Created by weqia on 14-6-6.
//  Copyright (c) 2014year xhb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
// 界面通信协议
typedef void(^XHBViewControllerCommCallback)(id data);

@protocol XHBViewControllerCommProtocol <NSObject>
@optional
@property(nonatomic,copy)XHBViewControllerCommCallback backActionCallback;
@property(nonatomic,copy)XHBViewControllerCommCallback finishActionCallback;
@property(nonatomic,copy)XHBViewControllerCommCallback updatedBack;
@property(nonatomic,copy)XHBViewControllerCommCallback viewDidAppearCallback;
@property(nonatomic,weak)UIViewController<XHBViewControllerCommProtocol> * fatherController;
@property(nonatomic)NSInteger updateKey;
@property(nonatomic)BOOL shouldUpdate;
@property(nonatomic)BOOL updated;

-(void)update;

-(void)reload;

-(void)initDataForView:(id)object forKey:(NSString*)key;

@end

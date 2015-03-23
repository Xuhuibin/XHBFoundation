//
//  XHBBaseModel.h
//  XHBFoundation
//
//  Created by weqia on 14-9-19.
//  Copyright (c) 2014年 xhb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"
#import "XHBEntityOperationProtocol.h"
@interface XHBBaseModel : Jastor<XHBEntityOperationProtocol>

@property(nonatomic)NSUInteger relateTransportId;  //与之关联的 消息传输体ID

@end

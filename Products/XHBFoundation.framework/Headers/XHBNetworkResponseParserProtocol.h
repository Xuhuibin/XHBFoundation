//
//  XHBNetworkResponseParserProtocol.h
//  XHBFoundationEdit
//
//  Created by weqia on 14-9-28.
//  Copyright (c) 2014年 xhb. All rights reserved.
//

#import <Foundation/Foundation.h>

///   网络响应数据实体解析协议

@protocol XHBNetworkResponseParserProtocol <NSObject>

-(NSArray*)getArrayObjects:(Class)cls;

-(id)getSingleObject:(Class)cls;

-(id)getErrorObject;

-(BOOL)isSuccess;

@end

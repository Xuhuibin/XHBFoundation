//
//  XHBValidateUtil.h
//  XHBFoundationEdit
//
//  Created by weqia on 14-9-27.
//  Copyright (c) 2014year xhb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHBValidateUtil : NSObject

+(BOOL)isURL:(NSString*)url;

+(BOOL)isMobile:(NSString*)mobile;

+(BOOL)isNumber:(NSString*)number;

+(BOOL)isUInteger:(NSString*)number; //是否为正整数

@end

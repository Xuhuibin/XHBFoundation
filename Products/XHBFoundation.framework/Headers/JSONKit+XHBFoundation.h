//
//  JSONKit+XHBFoundation.h
//  Weqia
//
//  Created by weqia on 14-11-11.
//  Copyright (c) 2014年 xhb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XHBFoundation/JSONKit.h>

@interface NSString (XHBFoundation)


+(NSArray*)arrayObjects:(NSString*)json cls:(Class)cls;

+(id)singleObject:(NSString*)json cls:(Class)cls;

@end

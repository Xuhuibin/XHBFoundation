//
//  Jastor.h
//  XHBFoundation
//
//  Created by weqia on 14-9-28.
//  Copyright (c) 2014年 xhb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Jastor : NSObject
+ (id)objectFromDictionary:(NSDictionary*)dictionary;

- (id)initWithDictionary:(NSDictionary *)dictionary;

- (NSMutableDictionary *)toDictionary;

-(NSMutableDictionary*)toDictionaryWithProperty:(BOOL(^)(NSString * propertyName))property;
@end

//
//  NSMutableDictionary+XHBFoundation.h
//  XHBFoundation
//
//  Created by weqia on 15-1-13.
//  Copyright (c) 2015 year xhb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (XHBFoundation)
-(id)threadSafeObjectForKey:(id)aKey;
-(void)threadSafeSetObject:(id)anObject forKey:(id<NSCopying>)aKey;
-(void)threadSafeRemoveObjectForKey:(id<NSCopying>)aKey;
@end

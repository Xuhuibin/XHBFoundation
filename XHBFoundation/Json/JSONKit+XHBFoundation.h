//
//  JSONKit+XHBFoundation.h
//  Weqia
//
//  Created by weqia on 14-11-11.
//  Copyright (c) 2014year xhb. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (XHBFoundation)


+(NSArray*)arrayObjects:(id)json cls:(Class)cls;

+(id)singleObject:(id)json cls:(Class)cls;

@end

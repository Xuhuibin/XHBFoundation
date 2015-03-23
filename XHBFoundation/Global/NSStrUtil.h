//
//  StrUtil.h
//  OrderFood
//
//  Created by Berwin on 13-4-10.
//  Copyright (c) 2013year Berwin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSStrUtil : NSObject

+ (BOOL) isEmptyOrNull:(NSString*) string;

+ (BOOL) notEmptyOrNull:(NSString*) string;

+ (NSString *)trimString:(NSString *) str;

+ (BOOL)couldDownloadFile:(NSString*)mimeType;

@end

@interface NSString (MyExtensions)
- (NSString *) md5;

- (unsigned long long)unsignedLongLongValue;

@end

@interface NSData (MyExtensions)
- (NSString*)md5;
@end

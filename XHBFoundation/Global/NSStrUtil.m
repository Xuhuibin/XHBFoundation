//
//  StrUtil.m
//  OrderFood
//
//  Created by Berwin on 13-4-10.
//  Copyright (c) 2013year Berwin. All rights reserved.
//

#import "NSStrUtil.h"
#import <CommonCrypto/CommonDigest.h> // Need to import for CC_MD5 access

@implementation NSStrUtil


+ (BOOL) isEmptyOrNull:(NSString*) string
{
   return ![self notEmptyOrNull:string];
    
}

+ (BOOL) notEmptyOrNull:(NSString*) string
{
    if (string==nil) {
        return NO;
    }
    if([string isKindOfClass:[NSNull class]])
        return NO;
    if ([string isKindOfClass:[NSNumber class]]) {
        if (string != nil) {
            return  YES;
        }
        return NO;
    } else {
        string=[self trimString:string];
        if (string != nil && string.length > 0 && ![string isEqualToString:@"null"]&&![string isEqualToString:@"(null)"]&&![string isEqualToString:@" "]) {
            return  YES;
        }
        return NO;
    }
}



+ (NSString*) makeNode:(NSString*) str{
    return [[NSString alloc] initWithFormat:@"<node>%@</node>", str];
}

+ (NSString *)trimString:(NSString *) str {
    if ([str isKindOfClass:[NSString class]]) {
        return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }else{
        return nil;
    }
    
}

+ (BOOL)couldDownloadFile:(NSString*)mimeType
{
    if ([mimeType isKindOfClass:[NSString class]]&&mimeType!=nil) {
        if ([mimeType rangeOfString:@"application"].location!=NSNotFound) {
            return YES;
        }else if ([mimeType rangeOfString:@"audio"].location!=NSNotFound) {
            return YES;
        }else if ([mimeType rangeOfString:@"video"].location!=NSNotFound) {
            return YES;
        }else if ([mimeType rangeOfString:@"image"].location!=NSNotFound) {
            return YES;
        }else if ([mimeType rangeOfString:@"text/plain"].location!=NSNotFound) {
            return YES;
        }else if ([mimeType rangeOfString:@"text/xml"].location!=NSNotFound) {
            return YES;
        }else if ([mimeType rangeOfString:@"text/css"].location!=NSNotFound) {
            return YES;
        }else if ([mimeType rangeOfString:@"text/javascript"].location!=NSNotFound) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}


@end

@implementation NSString (MyExtensions)
- (NSString*)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int)strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (unsigned long long)unsignedLongLongValue
{
    return self.longLongValue;
}
-(long)longValue
{
    return self.integerValue;
}

@end

@implementation NSData (MyExtensions)
- (NSString*)md5
{
    unsigned char result[16];
    CC_MD5( self.bytes, (unsigned int)self.length, result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end

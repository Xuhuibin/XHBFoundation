//
//  UIDevice+XHBFoundation.m
//  XHBFoundation
//
//  Created by weqia on 14-12-30.
//  Copyright (c) 2014year xhb. All rights reserved.
//
#include <sys/types.h>
#include <sys/sysctl.h>
#import "UIDevice+XHBFoundation.h"

@implementation UIDevice (XHBFoundation)

- (NSString*)getDeviceVersion
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    //NSString *platform = [NSStringstringWithUTF8String:machine];二者等效
    free(machine);
    return platform;
}

-(NSString*)detailModel
{
    NSString *platform = [self getDeviceVersion];
    if ([platform isEqualToString:@"iPhone1,1"])   return@"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])   return@"iPhone 3G";
    
    if ([platform isEqualToString:@"iPhone2,1"])   return@"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"])   return@"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"])   return@"iphone 4(联通)";
    if ([platform isEqualToString:@"iPhone3,3"])   return@"iPhone 4(电信)";
    
    if ([platform isEqualToString:@"iPhone4,1"])   return@"iphone 4S";
    
    if ([platform isEqualToString:@"iphone5,1"])   return@"iphone5(移动,联通)";
    if ([platform isEqualToString:@"iPhone5,2"])   return@"iphone5(移动,电信,联通)";
    
    if ([platform isEqualToString:@"iPod1,1"])     return@"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])     return@"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])     return@"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])     return@"iPod Touch 4G";
    if ([platform isEqualToString:@"iPad1,1"])     return@"iPad";
    if ([platform isEqualToString:@"iPad2,1"])     return@"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])     return@"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])     return@"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"i386"])        return@"Simulator";
    return platform;
}
@end

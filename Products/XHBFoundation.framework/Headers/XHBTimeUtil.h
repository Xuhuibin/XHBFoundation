//
//  XHBTimeUtil.h
//  XHBFoundationEdit
//
//  Created by weqia on 14-9-26.
//  Copyright (c) 2014年 xhb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHBTimeUtil : NSObject

+(NSInteger)dayCountForMonth:(int)month andYear:(int)year;    //某个月的天数

+(BOOL)isLeapYear:(int)year;    //是否是闰年

+(BOOL)isSameDay:(long long)time otherTime:(NSInteger)time;  //是否为同一天

+(NSInteger)differenceDaysBetweenTime:(NSInteger)time withTime:(NSInteger)withTime; // 两个时间相差的天数

+(NSString*)now;

+(NSString*)timeString:(float)time;

+(NSString*)nowStringWithRandom; //  year-month-day hour:minute -arc4random

+(NSString*)nowString;

+(NSDate*)dateForTimestamp:(NSString*)string;

+ (NSString*)getTimeStr1:(long long)time;

+(NSString*) getTimeStrStyle1:(long long)time;

+ (NSString*)getTimeStr1Short:(long long)time;

+(NSString*) getTimeStrStyle2:(long long)time;

+(NSString*) getTimeStrStyle3:(long long)time;

+(NSString*) getTimeStrStyle4:(long long)time;

+(NSString*)getWeekDayStr:(long long)time;

+(NSAttributedString*)getTimeStrStyle3WithColor:(long long)time;

+(NSDateComponents*) getComponent:(long long)otherTime;

@end

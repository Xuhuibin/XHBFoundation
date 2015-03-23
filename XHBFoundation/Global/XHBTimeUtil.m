//
//  XHBTimeUtil.m
//  XHBFoundationEdit
//
//  Created by weqia on 14-9-26.
//  Copyright (c) 2014year xhb. All rights reserved.
//

#import "XHBTimeUtil.h"
#import <UIKit/UIKit.h>


@implementation XHBTimeUtil


+(NSInteger)dayCountForMonth:(int)month andYear:(int)year
{
    if (month==1||month==3||month==5||month==7||month==8||month==10||month==12) {
        return 31;
    }else if(month==4||month==6||month==9||month==11){
        return 30;
    }else if([self isLeapYear:year]){
        return 29;
    }else{
        return 28;
    }
}
+(BOOL)isLeapYear:(int)year
{
    if (year%400==0) {
        return YES;
    }else{
        if (year%4==0&&year%100!=0) {
            return YES;
        }else{
            return NO;
        }
    }
}
+(BOOL)isSameDay:(long long)time otherTime:(long long)otherTime
{
    time=time/1000;
    otherTime=otherTime/1000;
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSDate * otherDate=[NSDate dateWithTimeIntervalSince1970:otherTime];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit;
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    
    NSInteger month=[component month];
    NSInteger day=[component day];
    NSInteger year=[component year];
    
    component=[calendar components:unitFlags fromDate:otherDate];
    NSInteger withMonth=[component month];
    NSInteger withDay=[component day];
    NSInteger withYear=[component year];
    if (year==withYear&&month==withMonth&&day==withDay) {
        return YES;
    }else{
        return NO;
    }
}
+(NSInteger)differenceDaysBetweenTime:(long long)time withTime:(long long)withTime
{
    time=time/1000;
    withTime=withTime/1000;
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    
    NSInteger month=[component month];
    NSInteger day=[component day];
    NSInteger year=[component year];
    
    NSDate * withDate=[NSDate dateWithTimeIntervalSince1970:withTime];
    component=[calendar components:unitFlags fromDate:withDate];
    NSInteger withMonth=[component month];
    NSInteger withDay=[component day];
    NSInteger withYear=[component year];
    
    NSDateComponents * com=[[NSDateComponents alloc]init];
    [com setDay:day];
    [com setYear:year];
    [com setMonth:month];
    
    NSDate * newdate=[calendar dateFromComponents:com];
    
    [com setYear:withYear];
    [com  setMonth:withMonth];
    [com setDay:withDay];
    NSDate *newWithDate=[calendar dateFromComponents:com];
    
    time=[newdate timeIntervalSince1970];
    withTime=[newWithDate timeIntervalSince1970];
    
    NSInteger distance=withTime-time;
    if (distance<0) {
        distance=-distance;
    }
    return distance/60/60/24;
}
+(NSString*)now
{
    NSDate *date=[NSDate date];
    NSTimeInterval  time=[date timeIntervalSince1970MS];
    NSString * string=[NSString stringWithFormat:@"%lld",(long long)time];
    return string;
}


+(NSString*)nowStringWithRandom 
{
    
    return [NSString stringWithFormat:@"%@_%d",[self nowString], arc4random() % 1000000];
}
+(NSString*)nowString
{
    NSDate *date=[NSDate date];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    
    NSInteger year=[component year];
    NSInteger month=[component month];
    NSInteger day=[component day];
    return [NSString stringWithFormat:@"%4d%2d%2d",year,month,day];
}
+(NSInteger)getNowYear
{
    NSDate *date=[NSDate date];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    return [component year];
}


+(NSString*)timeString:(float)time
{
    time=time/1000;
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    
    NSInteger year=[component year];
    NSInteger month=[component month];
    NSInteger day=[component day];
    NSInteger hour=[component hour];
    NSInteger minute=[component minute];
    NSInteger week=[component week];
    NSInteger weekday=[component weekday];
    
    NSDate * today=[NSDate date];
    component=[calendar components:unitFlags fromDate:today];
    
    NSInteger t_year=[component year];
    NSInteger t_month=[component month];
    NSInteger t_day=[component day];
    NSInteger t_week=[component week];
    
    NSString*string=nil;
    if(year==t_year&&month==t_month&&day==t_day)
    {
        if(hour<6&&hour>=0)
            string=[NSString stringWithFormat:@"凌晨 %ld:%02ld",(long)hour,(long)minute];
        else if(hour>=6&&hour<12)
            string=[NSString stringWithFormat:@"上午 %ld:%02ld",(long)hour,(long)minute];
        else if(hour>=12&&hour<18)
            string=[NSString stringWithFormat:@"下午 %ld:%02ld",(long)hour,(long)minute];
        else
            string=[NSString stringWithFormat:@"晚上 %ld:%02ld",(long)hour,(long)minute];
    }
    else if(year==t_year&&week==t_week)
    {
        NSString * daystr=nil;
        switch (weekday) {
            case 1:
                daystr=@"日";
                break;
            case 2:
                daystr=@"一";
                break;
            case 3:
                daystr=@"二";
                break;
            case 4:
                daystr=@"三";
                break;
            case 5:
                daystr=@"四";
                break;
            case 6:
                daystr=@"五";
                break;
            case 7:
                daystr=@"六";
                break;
            default:
                break;
        }
        string=[NSString stringWithFormat:@"周%@ %ld:%02ld",daystr,(long)hour,(long)minute];
    }
    else if(year==t_year)
        string=[NSString stringWithFormat:@"%ld月%ld日 %ld:%02ld",(long)month,(long)day,(long)hour,(long)minute];
    else
        string=[NSString stringWithFormat:@"%ldyear%ld月%ld日",(long)year,(long)month,(long)day];
    
    return string;
}
+(NSDate*)dateForTimestamp:(NSString*)string
{
    long long time=string.longLongValue;
    time=time/1000;
    if (time==0) {
        return nil;
    }
    return [NSDate dateWithTimeIntervalSince1970:time];
}

+ (NSString*)getTimeStr:(long) createdAt
{
    if (createdAt==0) {
        return nil;
    }
    // Calculate distance time string
    //
    NSString *timestamp;
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now, createdAt);
    if (distance < 0) distance = 0;
    
    if (distance < 60) {
        timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "second ago" : "seconds ago"];
    }
    else if (distance < 60 * 60) {
        distance = distance / 60;
        timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "minute ago" : "minutes ago"];
    }
    else if (distance < 60 * 60 * 24) {
        distance = distance / 60 / 60;
        timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "hour ago" : "hours ago"];
    }
    else if (distance < 60 * 60 * 24 * 7) {
        distance = distance / 60 / 60 / 24;
        timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "day ago" : "days ago"];
    }
    else if (distance < 60 * 60 * 24 * 7 * 4) {
        distance = distance / 60 / 60 / 24 / 7;
        timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "week ago" : "weeks ago"];
    }
    else {
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterShortStyle];
            [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        }
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt];
        timestamp = [dateFormatter stringFromDate:date];
    }
    return timestamp;
}

+ (NSString*)getTimeStr1:(long long)time
{
    if (time==0) {
        return nil;
    }
    time=time/1000;
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    NSString * string=[NSString stringWithFormat:@"%04d-%02d-%02d %02d:%02d",[component year],[component month],[component day],[component hour],[component minute]];
    return string;
}

+ (NSString*)getTimeStr1Short:(long long)time
{
    if (time==0) {
        return nil;
    }
    time=time/1000;
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    NSString * string=[NSString stringWithFormat:@"%04d-%02d-%02d",[component year],[component month],[component day]];
    return string;
}

+ (NSString*)getMDStr:(long long)time
{
    if (time==0) {
        return nil;
    }
    time=time/1000;
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    NSString * string=[NSString stringWithFormat:@"%d月%d日",[component month],[component day]];
    return string;
}

+(NSDateComponents*) getComponent:(long long)time
{
    if (time==0) {
        return nil;
    }
    time=time/1000;
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    return component;
}


+(NSString*) getTimeStrStyle1:(long long)time
{
    if (time==0) {
        return nil;
    }
    time=time/1000;
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    
    int year=[component year];
    int month=[component month];
    int day=[component day];
    
    int hour=[component hour];
    int minute=[component minute];
    
    NSDate * today=[NSDate date];
    component=[calendar components:unitFlags fromDate:today];
    
    int t_year=[component year];
    
    NSString*string=nil;
    
    long long now=[today timeIntervalSince1970];
    
    long distance=now-time;
    if(distance<60)
        string=@"刚刚";
    else if(distance<60*60)
        string=[NSString stringWithFormat:@"%ld分钟前",distance/60];
    else if(distance<60*60*24)
        string=[NSString stringWithFormat:@"%ld小时前",distance/60/60];
    else if(distance<60*60*24*7)
        string=[NSString stringWithFormat:@"%ld天前",distance/60/60/24];
    else if(year==t_year)
        string=[NSString stringWithFormat:@"%02d-%02d %d:%02d",month,day,hour,minute];
    else
        string=[NSString stringWithFormat:@"%d-%d-%d",year,month,day];
    
    return string;
}

+(NSString*) getTimeStrStyle4:(long long)time
{
    if (time==0) {
        return nil;
    }
    time=time/1000;
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    
    int year=[component year];
    int month=[component month];
    int day=[component day];
    
    NSString*string=[NSString stringWithFormat:@"%d/%02d/%02d",year,month,day];
    
    
    return string;
}

+(BOOL)samMonth:(long long)time withTime:(long long)withTime
{
    NSDateComponents* precom=[XHBTimeUtil  getComponent:time];
    NSUInteger preday=[precom day];
    NSUInteger premonth=[precom month];
    NSDateComponents* com=[XHBTimeUtil  getComponent:withTime];
    NSUInteger day=[com day];
    NSUInteger month=[com month];
    if (preday==day&&premonth==month) {
        return YES;
    }else{
        return NO;
    }
}

+(NSString*) getTimeStrStyle2:(long long)time
{
    if (time==0) {
        return nil;
    }
    time=time/1000;
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    
    int year=[component year];
    int month=[component month];
    int day=[component day];
    int hour=[component hour];
    int minute=[component minute];
    int week=[component week];
    int weekday=[component weekday];
    
    NSDate * today=[NSDate date];
    component=[calendar components:unitFlags fromDate:today];
    
    int t_year=[component year];
    int t_month=[component month];
    int t_day=[component day];
    int t_week=[component week];
    
    NSString*string=nil;
    if(year==t_year&&month==t_month&&day==t_day)
    {
        NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
        if ([formatStringForHours rangeOfString:@"a"].location==NSNotFound) {
            string=[NSString stringWithFormat:@"%02d:%02d",hour,minute];
        }else{
            if(hour<6&&hour>=0)
                string=[NSString stringWithFormat:@"凌晨 %d:%02d",hour,minute];
            else if(hour>=6&&hour<12)
                string=[NSString stringWithFormat:@"上午 %d:%02d",hour,minute];
            else if(hour==12)
                string=[NSString stringWithFormat:@"下午 %d:%02d",hour,minute];
            else if(hour>12&&hour<18)
                string=[NSString stringWithFormat:@"下午 %d:%02d",hour-12,minute];
            else
                string=[NSString stringWithFormat:@"晚上 %d:%02d",hour-12,minute];
        }
    }
    else if(year==t_year&&week==t_week)
    {
        NSString * daystr=nil;
        switch (weekday) {
            case 1:
                daystr=@"日";
                break;
            case 2:
                daystr=@"一";
                break;
            case 3:
                daystr=@"二";
                break;
            case 4:
                daystr=@"三";
                break;
            case 5:
                daystr=@"四";
                break;
            case 6:
                daystr=@"五";
                break;
            case 7:
                daystr=@"六";
                break;
            default:
                break;
        }
        string=[NSString stringWithFormat:@"周%@ %d:%02d",daystr,hour,minute];
    }
    else if(year==t_year)
        string=[NSString stringWithFormat:@"%d月%d日 %d:%02d",month,day,hour,minute];
    else
        string=[NSString stringWithFormat:@"%dyear%d月%d日",year,month,day];
    
    return string;
}

+(NSString*) getTimeStrStyle3:(long long)time showHM:(BOOL)showHM
{
    if (time==0) {
        return nil;
    }
    time=time/1000;
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    
    NSDate * today=[NSDate date];
    long long now=[today timeIntervalSince1970];
    component=[calendar components:unitFlags fromDate:today];
    
    long long distance=time-now;
    if (distance<=0) {
        if(distance>-60*60){
            return [NSString stringWithFormat:@"过期%lld分钟",-distance/60];
        }else if(distance>-60*60*24){
            return [NSString stringWithFormat:@"过期%lld个小时",-distance/60/60];
        }else{
            return [NSString stringWithFormat:@"过期%lld天",-distance/60/60/24];
        }
    }else if(distance<60*60){
        return [NSString stringWithFormat:@"剩余%lld分钟",distance/60];
    }else if(distance<60*60*24){
        return [NSString stringWithFormat:@"剩余%lld个小时",distance/60/60];
    }else{
        return [NSString stringWithFormat:@"剩余%lld天",distance/60/60/24];
    }
}
+(NSString*)getBirthdayString:(long long)time
{
    if (time==0) {
        return nil;
    }
    time=time/1000;
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    return [NSString stringWithFormat:@"%04dyear%02d月%02d日",[component year],[component month],[component day]];
}
+(NSString*)getWeekDayStr:(long long)time
{
    if (time==0) {
        return nil;
    }
    time=time/1000;
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    int weekday=[component weekday];
    NSString * daystr=nil;
    switch (weekday) {
        case 1:
            daystr=@"星期日";
            break;
        case 2:
            daystr=@"星期一";
            break;
        case 3:
            daystr=@"星期二";
            break;
        case 4:
            daystr=@"星期三";
            break;
        case 5:
            daystr=@"星期四";
            break;
        case 6:
            daystr=@"星期五";
            break;
        case 7:
            daystr=@"星期六";
            break;
        default:
            break;
    }
    return daystr;
}

+ (UIColor *)colorWithIntegerValue:(NSUInteger)value alpha:(CGFloat)alpha {
    NSUInteger mask = 255;
    NSUInteger blueValue = value & mask;
    value >>= 8;
    NSUInteger greenValue = value & mask;
    value >>= 8;
    NSUInteger redValue = value & mask;
    return [UIColor colorWithRed:(CGFloat)(redValue / 255.0) green:(CGFloat)(greenValue / 255.0) blue:(CGFloat)(blueValue / 255.0) alpha:alpha];
}

+(NSAttributedString*)getTimeStrStyle3WithColor:(long long)time showHM:(BOOL)showHM
{
    if (time==0) {
        return nil;
    }
    time=time/1000;
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    
    NSDate * today=[NSDate date];
    long long now=[today timeIntervalSince1970];
    component=[calendar components:unitFlags fromDate:today];
    
    
    NSDictionary * darkDic=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor darkGrayColor],NSForegroundColorAttributeName, nil];
    NSDictionary * blurDic=[NSDictionary dictionaryWithObjectsAndKeys:[self colorWithIntegerValue:0x0099cc alpha:1],NSForegroundColorAttributeName, nil];
    long long distance=time-now;
    if (showHM) {
        
        
        if (distance<=0) {
            if(distance>-60*60){
                NSMutableAttributedString * string=[[NSMutableAttributedString alloc]init];
                NSAttributedString * str=[[NSAttributedString alloc] initWithString:@"过期" attributes:darkDic];
                [string appendAttributedString:str];
                str=[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%lld",-distance/60] attributes:blurDic];
                [string appendAttributedString:str];
                str=[[NSAttributedString alloc] initWithString:@"分钟" attributes:darkDic];
                [string appendAttributedString:str];
                return string;
            }else if(distance>-60*60*24){
                NSMutableAttributedString * string=[[NSMutableAttributedString alloc]init];
                NSAttributedString * str=[[NSAttributedString alloc] initWithString:@"过期" attributes:darkDic];
                [string appendAttributedString:str];
                str=[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%lld",-distance/60/60] attributes:blurDic];
                [string appendAttributedString:str];
                str=[[NSAttributedString alloc] initWithString:@"小时" attributes:darkDic];
                [string appendAttributedString:str];
                return string;
            }else{
                NSMutableAttributedString * string=[[NSMutableAttributedString alloc]init];
                NSAttributedString * str=[[NSAttributedString alloc] initWithString:@"过期" attributes:darkDic];
                [string appendAttributedString:str];
                str=[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%lld",-distance/60/60/24] attributes:blurDic];
                [string appendAttributedString:str];
                str=[[NSAttributedString alloc] initWithString:@"天" attributes:darkDic];
                [string appendAttributedString:str];
                return string;
            }
        }else if(distance<60*60){
            NSMutableAttributedString * string=[[NSMutableAttributedString alloc]init];
            NSAttributedString * str=[[NSAttributedString alloc] initWithString:@"还剩" attributes:darkDic];
            [string appendAttributedString:str];
            str=[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%lld",distance/60] attributes:blurDic];
            [string appendAttributedString:str];
            str=[[NSAttributedString alloc] initWithString:@"分钟" attributes:darkDic];
            [string appendAttributedString:str];
            return string;
        }else if(distance<60*60*24){
            NSMutableAttributedString * string=[[NSMutableAttributedString alloc]init];
            NSAttributedString * str=[[NSAttributedString alloc] initWithString:@"还剩" attributes:darkDic];
            [string appendAttributedString:str];
            str=[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%lld",distance/60/60] attributes:blurDic];
            [string appendAttributedString:str];
            str=[[NSAttributedString alloc] initWithString:@"小时" attributes:darkDic];
            [string appendAttributedString:str];
            return string;
        }else{
            NSMutableAttributedString * string=[[NSMutableAttributedString alloc]init];
            NSAttributedString * str=[[NSAttributedString alloc] initWithString:@"还剩" attributes:darkDic];
            [string appendAttributedString:str];
            str=[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%lld",distance/60/60/24+1] attributes:blurDic];
            [string appendAttributedString:str];
            str=[[NSAttributedString alloc] initWithString:@"天" attributes:darkDic];
            [string appendAttributedString:str];
            return string;
        }
    }else{
        NSInteger day =[self differenceDaysBetweenTime:time*1000 withTime:now*1000];
        if (day==0) {
            NSMutableAttributedString * string=[[NSMutableAttributedString alloc]init];
            NSAttributedString * str=[[NSAttributedString alloc] initWithString:@"还剩" attributes:darkDic];
            [string appendAttributedString:str];
            str=[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld",1] attributes:blurDic];
            [string appendAttributedString:str];
            str=[[NSAttributedString alloc] initWithString:@"天" attributes:darkDic];
            [string appendAttributedString:str];
            return string;
        }else{
            if (distance<0) {
                NSMutableAttributedString * string=[[NSMutableAttributedString alloc]init];
                NSAttributedString * str=[[NSAttributedString alloc] initWithString:@"过期" attributes:darkDic];
                [string appendAttributedString:str];
                str=[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld",day] attributes:blurDic];
                [string appendAttributedString:str];
                str=[[NSAttributedString alloc] initWithString:@"天" attributes:darkDic];
                [string appendAttributedString:str];
                return string;
            }else{
                NSMutableAttributedString * string=[[NSMutableAttributedString alloc]init];
                NSAttributedString * str=[[NSAttributedString alloc] initWithString:@"还剩" attributes:darkDic];
                [string appendAttributedString:str];
                str=[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld",day+1] attributes:blurDic];
                [string appendAttributedString:str];
                str=[[NSAttributedString alloc] initWithString:@"天" attributes:darkDic];
                [string appendAttributedString:str];
                return string;
            }
        }
    }
}

@end


@implementation NSDate(XHBTimeUtil)

-(long long)timeIntervalSince1970MS
{
    NSTimeInterval time=[self timeIntervalSince1970];
    return  (long long)time*1000 ;
}

@end

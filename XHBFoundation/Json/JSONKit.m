
#import <Foundation/Foundation.h>
#import "JSONKit.h"



@implementation NSString (JSONKitDeserializing)
- (id)objectFromJSONString
{
    NSData * data=[self dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONWritingPrettyPrinted error:nil];
}

@end

@implementation NSString (JSONKitSerializing)
- (NSData *)JSONData
{
    NSData * data=[NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    return data;
}

- (NSString *)XHBJSONString
{
    NSData * data=[NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

@end

@implementation NSArray (JSONKitSerializing)
- (NSData *)JSONData
{
    NSData * data=[NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    return data;
}

- (NSString *)XHBJSONString
{
    NSData * data=[NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

@end

@implementation NSDictionary (JSONKitSerializing)
- (NSData *)JSONData
{
    NSData * data=[NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    return data;
}

- (NSString *)XHBJSONString
{
    NSData * data=[NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

@end
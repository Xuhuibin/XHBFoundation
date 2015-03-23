//
//  XHBBaseModel.m
//  XHBFoundation
//
//  Created by weqia on 14-9-19.
//  Copyright (c) 2014year xhb. All rights reserved.
//

#import "XHBBaseModel.h"
#import "NSObject+XHBKVO.h"
#import "JastorRuntimeHelper.h"

@interface XHBBaseModel()
{
    NSString * _description;
}
@end

@implementation XHBBaseModel

-(NSString*)description
{
    if (_description == nil) {
        return @"  ";
    }
    return _description;
}
-(void)setDescription:(NSString*)description
{
    _description = description;
}

+(NSString*)primaryKey
{
    return nil;
}

-(BOOL)inserToStorage
{
    return NO;
}
-(BOOL)deleteToStorage
{
    return NO;
}
-(BOOL)updateToStorage
{
    return NO;
}

-(void)inserToStorage:(void(^)(BOOL success))callback
{
}
-(void)inserToService:(void(^)(BOOL success))callback
{
}

-(void)deleteToStorage:(void(^)(BOOL success))callback
{}

-(void)deleteToService:(void(^)(BOOL success))callback
{}

-(void)updateToStorage:(void(^)(BOOL success))callback
{}

-(void)updateToService:(void(^)(BOOL success))callback
{}


+(void)loadDatasFromStorage:(void(^)(NSArray* datas))complete
{}

+(id<XHBEntityOperationProtocol>)loadSingleDataFromStorage:(id)param
{
    return nil;
}


+(void)loadDatasFromService:(void(^)(NSArray* datas))complete failed:(void(^)(id error))failed
{}

+(id<XHBEntityOperationProtocol>)loadSingleDataFromService:(id)param
{
    return nil;
}

+(void)loadSingleDataFromService:(id)object complete:(void(^)(id<XHBEntityOperationProtocol> data))complete
{
}
+(void)loadSingleDataFromStorage:(id)param complete:(void(^)(id<XHBEntityOperationProtocol> data))complete
{}

-(BOOL)validation:(NSError **)error
{
    return YES;
}
-(instancetype)copyWithZone:(NSZone *)zone
{
    return self;
}
-(void)calculate
{}

-(void)dealloc
{
    [self  removeAllPropertyCallbacks];
}



-(void)copyData:(id)data
{
    if ([NSStringFromClass([self class]) isEqualToString:NSStringFromClass([data class])]||[[data class] isSubclassOfClass:[self class]]||[[self class] isSubclassOfClass:[data class]]) {
        NSArray * propertys=[JastorRuntimeHelper  propertyNames:[data class]];
        for (NSString * property in propertys) {
            if ([JastorRuntimeHelper isPropertyExist:[self class] propertyName:property]&&[self propertyCouldCopy:property]) {
                if (![JastorRuntimeHelper isPropertyReadOnly:[self class] propertyName:property]) {
                    id value=[data valueForKey:property];
                    [self setValue:value forKey:property];
                }
            }
        }
    }
}

-(BOOL)propertyCouldCopy:(NSString*)propertyName
{
    return YES;
}


@end

//
//  XHBEntityOperationProtocol.h
//  XHBToolKit
//
//  Created by weqia on 14-6-5.
//  Copyright (c) 2014年 xhb. All rights reserved.
//

#import <Foundation/Foundation.h>


///  实体操作协议

@protocol XHBEntityOperationProtocol <NSObject,NSCopying>

+(NSString*)primaryKey;

@optional

/**
 *  同步方法(本地数据)
 */
-(BOOL)inserToStorage;
-(BOOL)deleteToStorage;
-(BOOL)updateToStorage;
+(id<XHBEntityOperationProtocol>)loadSingleDataFromStorage:(id)param;

+(void)loadSingleDataFromStorage:(id)param complete:(void(^)(id<XHBEntityOperationProtocol> data))complete;
/**
 *  异步方法(本地数据)
 */
-(void)inserToStorage:(void(^)(BOOL success))callback;
-(void)updateToStorage:(void(^)(BOOL success))callback;
-(void)deleteToStorage:(void(^)(BOOL success))callback;
+(void)loadDatasFromStorage:(void(^)(NSArray* datas))complete;





/**
 *  异步方法（网络数据）
 */
-(void)updateToService:(void(^)(BOOL success))callback;
-(void)inserToService:(void(^)(BOOL success))callback;
-(void)deleteToService:(void(^)(BOOL success))callback;
+(void)loadDatasFromService:(void(^)(NSArray* datas))complete failed:(void(^)(id error))failed;


/**
 *  同步方法(网络数据)
 */
+(id<XHBEntityOperationProtocol>)loadSingleDataFromService:(id)param;

+(void)loadSingleDataFromService:(id)param complete:(void(^)(id<XHBEntityOperationProtocol> data))complete;

/**
 *  数据验证
 */
-(BOOL)validation:(NSError **)error;

-(BOOL)validation;

/**
 *  实体计算
 */
-(void)calculate;

/**
 *  更新数据
 *
 *  @param name 更新键
 */
-(void)updateData:(NSString*)name;

/**
 *  复制数据
 *
 *  @param data 
 */
-(void)copyData:(id)data;


@end

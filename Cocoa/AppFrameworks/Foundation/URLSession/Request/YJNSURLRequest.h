//
//  YJNSURLRequest.h
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/11/29.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJNSHTTPBodyProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSString * YJNSHTTPMethod NS_STRING_ENUM; ///< 请求方式
FOUNDATION_EXPORT YJNSHTTPMethod const YJNSHTTPMethodGET;  ///< GET请求
FOUNDATION_EXPORT YJNSHTTPMethod const YJNSHTTPMethodPOST; ///< POST请求

/** NSURLRequest*/
@interface YJNSURLRequest : NSObject

@property (nonatomic) BOOL supportResume; ///< 是否支持网络重连

@property (nonatomic, strong) id<YJNSHTTPBodyProtocol> HTTPBody;  ///< 请求参数

@property (nonatomic, copy, readonly) NSString *identifier;      ///< 唯一标示
@property (nonatomic, weak, readonly) id source;                 ///< 发起网络请求的对象
@property (nonatomic, readonly) Class URLSessionTask;            ///< 网络会话任务对应的类
@property (nonatomic, copy, readonly) NSString *URL;             ///< 请求地址
@property (nonatomic, copy, readonly) YJNSHTTPMethod HTTPMethod; ///< 请求方式，默认YJNSHTTPMethodGET

/**
 *  @abstract 初始化YJNSURLRequest或其子类
 *  @discusstion 取消网络请求时使用
 *
 *  @param source 发起网络请求的对象
 *
 *  @return instancetype
 */
+ (instancetype)requestWithSource:(NSObject *)source;

/**
 *  @abstract 初始化YJNSURLRequest或其子类
 *  @discusstion 发送网络请求时使用
 *
 *  @param source 发起网络请求的对象
 *  @param body   请求参数
 *
 *  @return instancetype
 */
+ (instancetype)requestWithSource:(NSObject *)source HTTPBody:(id<YJNSHTTPBodyProtocol>)body;

@end

NS_ASSUME_NONNULL_END

//
//  YJNSURLSessionTask.m
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/11/29.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSURLSessionTask.h"
#import "YJDispatch.h"

@implementation YJNSURLSessionTask

+ (instancetype)taskWithRequest:(YJNSURLRequest *)request {
    YJNSURLSessionPool *sPool = YJNSURLSessionPool.sharedPool;
    YJNSURLSessionTask *task = sPool.poolDict[request.identifier];
    if (!task) {
        task = [[self alloc] init];
        task.request = request;
        sPool.poolDict[request.identifier] = task;
    }
    return task;
}

#pragma mark - getter & setter
- (YJNSURLSessionTaskSuccess)success {
    __weakSelf
    YJNSURLSessionTaskSuccess block = ^(id data) {
        __strongSelf
        if (strongSelf.state == YJNSURLSessionTaskStateRunning) {
            strongSelf -> _state = YJNSURLSessionTaskStateSuccess;
            if (strongSelf -> _success && strongSelf.request.source) {
                if (strongSelf.request.responseModelClass && [data isKindOfClass:[NSDictionary class]]) {
                    data = [[strongSelf.request.responseModelClass alloc] initWithModelDictionary:data];
                }
                dispatch_async_main(^{
                    strongSelf -> _success(data);
                });
            }
        }
    };
    return block;
}

- (YJNSURLSessionTaskFailure)failure {
    __weakSelf
    YJNSURLSessionTaskFailure block = ^(NSError *error) {
        __strongSelf
        NSLog(@"%@网络请求出错<<<<<<<<<<<<<<<%@", strongSelf.request.identifier, error);
        if (strongSelf.state == YJNSURLSessionTaskStateRunning) {
            strongSelf -> _state = YJNSURLSessionTaskStateFailure;
            if (strongSelf -> _failure && strongSelf.request.source) strongSelf -> _failure(error);
        }
    };
    return block;
}

#pragma mark -
- (instancetype)completionHandler:(YJNSURLSessionTaskSuccess)success failure:(YJNSURLSessionTaskFailure)failure {
    self.success = success;
    self.failure = failure;
    return self;
}

- (void)resume {
    NSLog(@"%@发出网络请求>>>>>>>>>>>>>>>%@", self.request.identifier, self.request.requestModel.modelDictionary);
    self -> _state = YJNSURLSessionTaskStateRunning;
    self.needResume = NO;
}

- (void)suspend {
    NSLog(@"%@暂停网络请求<<<<<<<<<<<<<<<", self.request.identifier);
    self -> _state = YJNSURLSessionTaskStateSuspended;
}

- (void)cancel {
    NSLog(@"%@取消网络请求<<<<<<<<<<<<<<<", self.request.identifier);
    self -> _state = YJNSURLSessionTaskStateCanceling;
    if (!self.request.supportResume) {
        [YJNSURLSessionPool.sharedPool.poolDict removeObjectForKey:self.request.identifier];
        _success = nil;
        _failure = nil;
    }
}

@end

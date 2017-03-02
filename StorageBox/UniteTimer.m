//
//  UniteTimer.m
//  StorageBox
//
//  Created by 聂海洲 on 2016/12/4.
//  Copyright © 2016年 meiyou. All rights reserved.
//

#import "UniteTimer.h"

@interface UniteTimer()

@property (nonatomic, assign) __block int countNumer;

@property (nonatomic, strong) dispatch_queue_t queue;

@property (nonatomic) dispatch_source_t nowTimer;

@end


@implementation UniteTimer

+(instancetype) sharedTimer {
    static UniteTimer * shareSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^{
        shareSingleton = [[UniteTimer alloc] init];
    });
    return shareSingleton;
}



//开启一个定时器并且回调
- (void) startCountWithMilliseconds:(int)ms callBackOnMain:(callBackOfTimer)callback{
    
    self.isCounting = YES;
    
    self.callback = callback;
    
    self.nowTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, self.queue);
    dispatch_source_set_timer(_nowTimer, dispatch_time(DISPATCH_TIME_NOW, 0), 100*NSEC_PER_MSEC, 0*NSEC_PER_SEC);//每0.1秒执行一次
    ms /= 100;
    self.countNumer = ms;
    dispatch_source_set_event_handler(self.nowTimer, ^{
        if(self.countNumer <= 0){ //倒计时结束，关闭
            self.isCounting = NO;
            dispatch_source_cancel(self.nowTimer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //回到了主线程
                callback(NO);
            });
        }else{
            self.countNumer--;
        }
    });
    dispatch_resume(self.nowTimer);
    
}

//取消定时器计时
-(void) cancelTimer{
    self.isCounting = NO;
    self.countNumer = -10;
    dispatch_source_cancel(self.nowTimer);
    self.callback(YES);
    
}

#pragma mark --- getter

-(dispatch_queue_t)queue{
    if (_queue == nil) {
        _queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    return _queue;
}


@end

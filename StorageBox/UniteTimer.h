//
//  UniteTimer.h
//  StorageBox
//
//  Created by 聂海洲 on 2016/12/4.
//  Copyright © 2016年 meiyou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^callBackOfTimer)(bool isCancel);


@interface UniteTimer : NSObject


//开启一个定时器并且回调
-(void) startCountWithMilliseconds:(int) ms callBackOnMain:(callBackOfTimer)callback;

//取消定时器计时
-(void) cancelTimer;

+(instancetype) sharedTimer;

@property (nonatomic, copy) callBackOfTimer callback;


@property (nonatomic, assign)bool isCounting;

@end

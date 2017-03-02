//
//  ScrollManager.m
//  StorageBox
//
//  Created by 聂海洲 on 2016/12/7.
//  Copyright © 2016年 meiyou. All rights reserved.
//

#import "ScrollManager.h"

#import "CoverView.h"

typedef void (^callBackOfScroll)();


@interface ScrollManager()

@property (nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, assign) __block int countNumer;

@property (nonatomic, strong) dispatch_queue_t queue;

@property (nonatomic) dispatch_source_t countingTimer;

@property (nonatomic) dispatch_block_t handle;

@property (nonatomic, copy) callBackOfScroll callBack;

@property (nonatomic, assign) bool isCounting;

@end



@implementation ScrollManager


- (void)registerGesture:(UILongPressGestureRecognizer *)longPress collectionView:(UICollectionView *)collectionView selectedCell:(UICollectionViewCell *)selectedCell{
    
    self.scrollView = collectionView;
    
    CGPoint location = [longPress locationInView:[CoverView sharedSingleton]];
    CGFloat scrollHeight = self.scrollView.frame.size.height;
    
    __weak __typeof(self) weakSelf = self;
    
    if ( longPress.state == UIGestureRecognizerStateBegan) {
        
        if (location.y < 80) {
            
            self.isCounting = YES;
            
            [self startCountPerMus:5 callBackOnMain:^{
                NSLog(@"counter shang");
                
                CGFloat offset = weakSelf.scrollView.contentOffset.y;
                if (offset > 0) {
                    [weakSelf.scrollView setContentOffset:CGPointMake(0,  offset -= 5) animated:NO];
                }else{
                    [weakSelf endCountAndScroll];
                }
            }];
        }else if(location.y > (scrollHeight - 80)){
            
            self.isCounting = YES;
            
            [self startCountPerMus:10 callBackOnMain:^{
                NSLog(@"counter xia");
                
                CGFloat offset = weakSelf.scrollView.contentOffset.y;
                //没有滑动到底边
                CGFloat contentHeight = weakSelf.scrollView.contentSize.height;
                CGFloat scrollViewHeight = weakSelf.scrollView.frame.size.height;
                
                if (contentHeight > (offset + scrollViewHeight)) {
                    [weakSelf.scrollView setContentOffset:CGPointMake(0,  offset += 5) animated:NO];
                }else{
                    [weakSelf endCountAndScroll];
                }
            }];
            
        }else{
            self.isCounting = NO;
        }
        

    }else if (longPress.state == UIGestureRecognizerStateChanged){
        
        
        if (location.y > (scrollHeight - 80)) {
            
            NSLog(@"移动到底部了-----");
            
            if (self.isCounting == NO) {
                
                [self startCountPerMus:10 callBackOnMain:^{
                    NSLog(@"counter xia");
                    
                    CGFloat offset = weakSelf.scrollView.contentOffset.y;
                    //没有滑动到底边
                    CGFloat contentHeight = weakSelf.scrollView.contentSize.height;
                    CGFloat scrollViewHeight = weakSelf.scrollView.frame.size.height;
                    
                    if (contentHeight > (offset + scrollViewHeight)) {
                        [weakSelf.scrollView setContentOffset:CGPointMake(0,  offset += 5) animated:NO];
                    }else{
                        [weakSelf endCountAndScroll];
                    }
                }];
                self.isCounting = YES;
            }
        }
        else if (location.y < 80){
            NSLog(@"移动到ding部了-----");
            
            if (self.isCounting == NO) {
                
                NSLog(@"执行了多少次");
                
                [self startCountPerMus:5 callBackOnMain:^{
                    NSLog(@"counter shang");
                    
                    CGFloat offset = weakSelf.scrollView.contentOffset.y;
                    if (offset > 0) {
                        [weakSelf.scrollView setContentOffset:CGPointMake(0,  offset -= 5) animated:NO];
                    }else{
                        [weakSelf endCountAndScroll];
                    }
                }];
                self.isCounting = YES;
            }
        }else{
            
            NSLog(@"移动到 中间 了-----");
            
            if (self.isCounting == YES) {
                self.isCounting = NO;
                [self endCountAndScroll];
            }
            
        }
    }else if (longPress.state == UIGestureRecognizerStateEnded){
        
        if (self.isCounting) {
            [self endCountAndScroll];
        }
    }
}


+(instancetype) sharedManager {
    static ScrollManager * shareSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^{
        shareSingleton = [[ScrollManager alloc] init];
    });
    return shareSingleton;
}

#pragma mark - GCD定时器
//开启一个定时器并且回调
- (void) startCountPerMus:(int)count callBackOnMain:(callBackOfScroll)callback{
    
    if (self.callBack != callback) {
        self.callBack = [callback copy];
    }
    int number = 1000/count;
    
    self.countingTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, self.queue);
    
    dispatch_source_set_timer(self.countingTimer, dispatch_time(DISPATCH_TIME_NOW, 0), number*NSEC_PER_MSEC, 0*NSEC_PER_SEC);//每0.1秒执行一次
    
    dispatch_source_set_event_handler(self.countingTimer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.callBack();
            });
    });
    
//    dispatch_source_set_event_handler(self.countingTimer, self.handle);
    dispatch_resume(self.countingTimer);
    
}
-(void)endCountAndScroll{
    [self cancelHandler];
}
//取消定时器计时
-(void) cancelHandler {
    dispatch_cancel(self.countingTimer);
//    dispatch_source_cancel(self.countingTimer);
//    dispatch_suspend(self.countingTimer);
//    dispatch_source_set_cancel_handler(self.countingTimer, self.handle);
//    dispatch_source_set_cancel_handler(self.countingTimer, ^{
//        dispatch_suspend(self.countingTimer);
//    });
}

#pragma mark --- getter
-(dispatch_queue_t)queue{
    if (_queue == nil) {
        _queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    return _queue;
}

//-(dispatch_source_t)countingTimer{
//    if (_countingTimer == nil) {
//        _countingTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, self.queue);
//    }
//    return _countingTimer;
//}
//-(dispatch_block_t)handle{
//    if (_handle == NULL) {
//        _handle = ^{
//            dispatch_async(dispatch_get_main_queue(), ^{
//                _callBack();
//            });
//        };
//    }
//    return _handle;
//}

@end

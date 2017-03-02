//
//  CoverView.m
//  StorageBox
//
//  Created by 聂海洲 on 2016/12/3.
//  Copyright © 2016年 meiyou. All rights reserved.
//

#import "CoverView.h"

#import <Foundation/Foundation.h>

#import "SettingData.h"

@implementation CoverView

//#pragma mark ---touchs
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [[UIApplication sharedApplication].keyWindow addSubview:self.imageView];
//    [self setImageViewPosWithTouchs:touches withEvent:event];
//}
//-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self setImageViewPosWithTouchs:touches withEvent:event];
//    
//}
//-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.imageView removeFromSuperview];
//    [self removeFromSuperview];
//}


//-(void) setImageViewPosWithTouchs:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSSet * allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
//    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
//    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
//    int x = point.x;
//    int y = point.y;
//    self.imageView.layer.position = CGPointMake(x, y);
//    
//    NSLog(@"touch (x, y) is (%d, %d)", x, y);
//    
//}

- (void) removeSelfAndImageView{
    [_imageView removeFromSuperview];
    [self removeFromSuperview];
}

-(UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CellHeight, CellWidth)];
        _imageView.backgroundColor = [UIColor redColor];
    }
    _imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [[UIApplication sharedApplication].keyWindow addSubview:_imageView];
    return _imageView;
}




+(instancetype) sharedSingleton {
    static CoverView * shareSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^{
        shareSingleton = [[CoverView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        shareSingleton.backgroundColor = [UIColor blackColor];
        shareSingleton.alpha = 0.2;
    });
    return shareSingleton;
}




@end

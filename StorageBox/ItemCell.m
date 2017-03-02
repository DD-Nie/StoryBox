//
//  ItemCell.m
//  StorageBox
//
//  Created by 聂海洲 on 2016/12/2.
//  Copyright © 2016年 meiyou. All rights reserved.
//
   
#import "ItemCell.h"

#import "CoverView.h"

@implementation ItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor redColor];
    
    UILongPressGestureRecognizer * press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
    [self addGestureRecognizer:press];
}

-(void)longPressed:(UILongPressGestureRecognizer *) g {
    
    _callBackOfLongpress(self, g);
    
}

//-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSSet * allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
//    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
//    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
//    int x = point.x;
//    int y = point.y;
//    
//    NSLog(@"touch (x, y) is (%d, %d)", x, y);
//}

//-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    return [CoverView sharedSingleton];
//}



- (void) addCallBackOfLongPressed:(CallBackOfLongPress) callback{
    if (_callBackOfLongpress == nil) {
        _callBackOfLongpress = callback;
    }
}

@end

//
//  LineView.m
//  StorageBox
//
//  Created by 聂海洲 on 2016/12/2.
//  Copyright © 2016年 meiyou. All rights reserved.
//

#import "LineView.h"

#define linPadding 2.5

@implementation LineView

//- (void)drawRect:(CGRect)rect{
//    [super drawRect:rect];
//    CGContextRef currentContext = UIGraphicsGetCurrentContext();
//    //设置虚线颜色
//    CGContextSetStrokeColorWithColor(currentContext, [UIColor colorWithRed:73/255.0f green:158/255.0f blue:248/255.0f alpha:1.0f].CGColor);
//    //设置虚线宽度
//    CGContextSetLineWidth(currentContext, 4);
//    //设置虚线绘制起点
////    CGContextMoveToPoint(currentContext, 0, 0);
//    CGContextMoveToPoint(currentContext, rect.origin.x, rect.origin.y + self.frame.size.height/2 - linPadding);
//    //设置虚线绘制终点
//    CGContextAddLineToPoint(currentContext, self.frame.origin.x + self.frame.size.width, rect.origin.y + self.frame.size.height/2 - linPadding);
//    
//    
//    
//    CGContextMoveToPoint(currentContext, rect.origin.x, rect.origin.y + self.frame.size.height/2 + linPadding);
//    //设置虚线绘制终点
//    CGContextAddLineToPoint(currentContext, self.frame.origin.x + self.frame.size.width, rect.origin.y + self.frame.size.height/2 + linPadding);
//    
//    
//    
//    
//    
//    
//    
//    //设置虚线排列的宽度间隔:下面的arr中的数字表示先绘制3个点再绘制1个点
//    CGFloat arr[] = {6, 2, 3 ,2};
//    //下面最后一个参数“2”代表排列的个数。
//    CGContextSetLineDash(currentContext, 0, arr, 4);
//    CGContextDrawPath(currentContext, kCGPathStroke);
//}

@end

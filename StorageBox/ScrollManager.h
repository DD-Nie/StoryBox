//
//  ScrollManager.h
//  StorageBox
//
//  Created by 聂海洲 on 2016/12/7.
//  Copyright © 2016年 meiyou. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface ScrollManager : NSObject


+(instancetype) sharedManager;


- (void)registerGesture:(UILongPressGestureRecognizer *)longPress collectionView:(UICollectionView *)collectionView selectedCell:(UICollectionViewCell *)selectedCell;

-(void)endCountAndScroll;


@end

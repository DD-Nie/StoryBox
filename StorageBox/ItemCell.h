//
//  ItemCell.h
//  StorageBox
//
//  Created by 聂海洲 on 2016/12/2.
//  Copyright © 2016年 meiyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemCell;
typedef void (^CallBackOfLongPress) (ItemCell * selectedCell, UILongPressGestureRecognizer * longPress);

@interface ItemCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UIImageView *frameImageView;
@property (weak, nonatomic) IBOutlet UIImageView *decorateImageView;

//标记cell可不可以进入计时状态 如果可以进入计时状态 则到达指定的时间后 跳转下个界面
//@property (nonatomic, assign)bool calculating;


@property (nonatomic, copy) CallBackOfLongPress callBackOfLongpress;

- (void) addCallBackOfLongPressed:(CallBackOfLongPress) callback;

@end

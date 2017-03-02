//
//  CoverView.h
//  StorageBox
//
//  Created by 聂海洲 on 2016/12/3.
//  Copyright © 2016年 meiyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoverView : UIView

@property (nonatomic , strong) UIImageView * imageView;

+( instancetype ) sharedSingleton;


- (void) removeSelfAndImageView;

@end

//
//  ViewController.m
//  StorageBox
//
//  Created by 聂海洲 on 2016/12/2.
//  Copyright © 2016年 meiyou. All rights reserved.
//

#import "ViewController.h"
#import "ItemCell.h"
#import "LineView.h"
#import "CoverView.h"
#import "UniteTimer.h"
#import "ScrollManager.h"


#define cellID @"cellID"
#define headerID @"headerID"
#define footerID @"footerID"

#define cellWidth (50)

#define ScreenWidth self.view.frame.size.width


@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout * flowLayout;


@property (nonatomic, strong) NSMutableArray * arrSection0;
//@property (nonatomic, strong) NSMutableArray * arrSection1;
//@property (nonatomic, strong) NSMutableArray * arrSection2;

@property (nonatomic, strong) UIView * coverView;

//试图要拖入目标的索引()
@property (nonatomic, strong) NSIndexPath * tempTargetIndex;
//选中的要移动的索引
@property (nonatomic, strong) NSIndexPath * selectedIndex;


@end

@implementation ViewController


//- (nullable NSIndexPath *)indexPathForItemAtPoint:(CGPoint)point;



#pragma mark --- getter
-(NSMutableArray *)arrSection0{
    if (_arrSection0 == nil) {
        _arrSection0 = [[NSMutableArray alloc] init];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
        [_arrSection0 addObject:@"123"];
    }
    return _arrSection0;
}
//-(NSMutableArray *)arrSection1{
//    if (_arrSection1 == nil) {
//        _arrSection1 = [[NSMutableArray alloc] init];
//        [_arrSection1 addObject:@"123"];
//        [_arrSection1 addObject:@"123"];
//        [_arrSection1 addObject:@"123"];
//    }
//    return _arrSection1;
//}
//-(NSMutableArray *)arrSection2{
//    if (_arrSection2 == nil) {
//        _arrSection2 = [[NSMutableArray alloc] init];
//        [_arrSection2 addObject:@"123"];
//        [_arrSection2 addObject:@"123"];
//        [_arrSection2 addObject:@"123"];
//    }
//    return _arrSection2;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadCollectionView];
}

- (void)loadCollectionView
{
    _flowLayout = [[UICollectionViewFlowLayout alloc] init]; // 自定义的布局对象
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:_flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
//    _collectionView.backgroundColor = [UIColor greenColor];
    
    
    
    // 注册cell、sectionHeader、sectionFooter
//    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [_collectionView registerNib:[UINib nibWithNibName:@"ItemCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellID];
    [_collectionView registerClass:[LineView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
    [_collectionView registerClass:[LineView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerID];
}
#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    if (section == 0) {
        return self.arrSection0.count;
//    }else if(section == 1){
//        return self.arrSection1.count;
//    }else if(section == 2){
//        return self.arrSection2.count;
//    }
//    return 3;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ItemCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    [cell addCallBackOfLongPressed:^(ItemCell *selectedCell, UILongPressGestureRecognizer *longPress) {
        
        [[UIApplication sharedApplication].keyWindow addSubview:[CoverView sharedSingleton]];
        [[ScrollManager sharedManager] registerGesture:longPress collectionView:collectionView selectedCell:selectedCell];
        
        if (longPress.state == UIGestureRecognizerStateBegan){
            
            
            [CoverView sharedSingleton].alpha = 0.0;
            [CoverView sharedSingleton].imageView.alpha = 1.0;
            
            //设置浮动图标初始情况的位置和移动动画
            CGPoint cellCenter = selectedCell.center;
            CGPoint localInCoverView = [[CoverView sharedSingleton] convertPoint:cellCenter fromView:collectionView];
            [CoverView sharedSingleton].imageView.center = localInCoverView;
            
            selectedCell.alpha = 0.2;
            
            [UIView animateWithDuration:0.2 animations:^{
                CGPoint pos = [longPress locationInView:[CoverView sharedSingleton]];
                [CoverView sharedSingleton].imageView.layer.position = pos;
            }];
        }
        else if (longPress.state == UIGestureRecognizerStateChanged){
            
            //设置浮动图标的跟随
            CGPoint pos = [longPress locationInView:[CoverView sharedSingleton]];
            [CoverView sharedSingleton].imageView.layer.position = pos;
            
            //移动到对应的cell的上方获取index
            CGPoint pointInCV = [longPress locationInView:collectionView];
            NSIndexPath * targetIndex = [collectionView indexPathForItemAtPoint:pointInCV];
            //选到了一个新的目标位置
            if(targetIndex != nil && _tempTargetIndex != targetIndex){
                
                //恢复划过的cell
                if (_tempTargetIndex != nil) {
                    ItemCell * cell = (ItemCell *)[collectionView cellForItemAtIndexPath:_tempTargetIndex];
                    NSLog(@"上一次的indexPath:  %ld", _tempTargetIndex.row);
                    cell.contentView.backgroundColor = [UIColor redColor];
                }
                
                //设置当前的选中的设置
                ItemCell * cell = (ItemCell *)[collectionView cellForItemAtIndexPath:targetIndex];
                cell.contentView.backgroundColor = [UIColor greenColor];
                
                _tempTargetIndex = targetIndex;
                NSLog(@"触发2222222222222");
                //开始触发异步计时
                [[UniteTimer sharedTimer] startCountWithMilliseconds:1000 callBackOnMain:^(bool isCancel) {
                    if (!isCancel) {//触发了打开指令
                        
                        cell.contentView.backgroundColor = [UIColor blueColor];
                        
                    }
                    else{
                        NSLog(@"取消");
                    }
                }];
                
            //如果是在当前的图标范围内移动
            }else if(targetIndex != nil && _tempTargetIndex == targetIndex){
                
                //判断是不是在自己起始的位置移动
                NSIndexPath * originIndex = [collectionView indexPathForCell:selectedCell];
                long originRow = originIndex.row;
                if (originRow == targetIndex.row) {
                    [[UniteTimer sharedTimer] cancelTimer];
                }
                
                
            
            //如果图标在任何不是cell的上边
            }else {
                
                //把上次选中的图标设置为原来的状态
                if (_tempTargetIndex != nil) {
                    ItemCell * cell = (ItemCell *)[collectionView cellForItemAtIndexPath:_tempTargetIndex];
                    NSLog(@"上一次的indexPath:  %ld", _tempTargetIndex.row);
                    cell.contentView.backgroundColor = [UIColor redColor];
                    _tempTargetIndex = nil;

                    //复位异步计时器
                    [[UniteTimer sharedTimer] cancelTimer];
                }
                
            }
            
        }
        else if (longPress.state == UIGestureRecognizerStateEnded) {
            
            //离开那一刻就不再计时
            [[UniteTimer sharedTimer] cancelTimer];
            
            //判断是不是在自己原来的位置松开
            CGPoint leavePoint = [longPress locationInView:collectionView];
            NSIndexPath * leaveIndex = [collectionView indexPathForItemAtPoint:leavePoint];
            long leaveRow = leaveIndex.row;
            long selectRow = [collectionView indexPathForCell:selectedCell].row;
            
            if ((leaveIndex != nil) && (leaveRow != selectRow)){//说明在一个目标位置松开, 并且不是自己的位置
                
                //放到目标位置
                ItemCell * cell = (ItemCell *)[collectionView cellForItemAtIndexPath:leaveIndex];
                CGPoint targetPoint = [[CoverView sharedSingleton] convertPoint:cell.center fromView:collectionView];
                
                [UIView animateWithDuration:0.2 animations:^{
                    [CoverView sharedSingleton].imageView.layer.position = targetPoint;
                    [CoverView sharedSingleton].alpha = 0.0;
                    [CoverView sharedSingleton].imageView.alpha = 0.5;
                } completion:^(BOOL finished) {
                    
                    [[CoverView sharedSingleton] removeSelfAndImageView];
                    
                    [collectionView performBatchUpdates:^{
                        NSIndexPath * removeIndexPath = [collectionView indexPathForCell:selectedCell];
                        [collectionView deleteItemsAtIndexPaths:@[removeIndexPath]];
                        [_arrSection0 removeObjectAtIndex:removeIndexPath.row];
                    } completion:^(BOOL finished) {
                        [[CoverView sharedSingleton] removeSelfAndImageView];
                        finished = YES;
                    }];
                }];
                
                
            }
            //没有到达长按的时间 并且在自己的位置松开
            else if ((leaveIndex != nil) && leaveRow == selectRow){
                
                //放回原来的地方
                CGPoint cellCenter = selectedCell.center;
                CGPoint localInCoverView = [[CoverView sharedSingleton] convertPoint:cellCenter fromView:collectionView];
                [UIView animateWithDuration:0.2 animations:^{
                    [CoverView sharedSingleton].imageView.center = localInCoverView;
                } completion:^(BOOL finished) {
                    selectedCell.alpha = 1.0;
                    selectedCell.contentView.backgroundColor = [UIColor redColor];
                    [[CoverView sharedSingleton] removeSelfAndImageView];
                    finished = YES;
                }];
                
                
            }
            else{//没有在指定的位置松开
                
                //放回原来的地方
                CGPoint cellCenter = selectedCell.center;
                CGPoint localInCoverView = [[CoverView sharedSingleton] convertPoint:cellCenter fromView:collectionView];
                [UIView animateWithDuration:0.2 animations:^{
                    [CoverView sharedSingleton].imageView.center = localInCoverView;
                } completion:^(BOOL finished) {
                    selectedCell.alpha = 1.0;
                    [[CoverView sharedSingleton] removeSelfAndImageView];
                    finished = YES;
                }];
            }
            
//            [[CoverView sharedSingleton] removeSelfAndImageView];
        }
        
    }];
    
    return cell;
}

// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        LineView *headerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerID forIndexPath:indexPath];
        if(headerView == nil)
        {
            headerView = [[LineView alloc] init];
        }
        headerView.backgroundColor = [UIColor whiteColor];
        
        return headerView;
    }
    else if([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        LineView *footerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerID forIndexPath:indexPath];
        if(footerView == nil)
        {
            footerView = [[LineView alloc] init];
        }
        footerView.backgroundColor = [UIColor whiteColor];
        return footerView;
    }
    
    return nil;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath
{
    
}




#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){100, 100};
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 15, 50, 15);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.f;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return (CGSize){ScreenWidth,20};
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return (CGSize){ScreenWidth,10};
}




#pragma mark ---- UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//// 点击高亮
//- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor greenColor];
//}


// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ItemCell * cell = (ItemCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor purpleColor];
    
//    CoverView * view = [CoverView sharedSingleton];
//    
//    if (view != nil) {
//        [self.collectionView addSubview:view];
//        [self.collectionView bringSubviewToFront:view];
//    }
    
    
    
    
    
}


// 长按某item，弹出copy和paste的菜单
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

// 使copy和paste有效
- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
{
    if ([NSStringFromSelector(action) isEqualToString:@"copy:"] || [NSStringFromSelector(action) isEqualToString:@"paste:"])
    {
        return YES;
    }
    
    return NO;
}

//
- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
{
    if([NSStringFromSelector(action) isEqualToString:@"copy:"])
    {
        //        NSLog(@"-------------执行拷贝-------------");
        [_collectionView performBatchUpdates:^{
            [_arrSection0 removeObjectAtIndex:indexPath.row];
            [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
        } completion:nil];
    }
    else if([NSStringFromSelector(action) isEqualToString:@"paste:"])
    {
        NSLog(@"-------------执行粘贴-------------");
    }
}

@end

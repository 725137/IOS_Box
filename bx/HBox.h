//
//  HBox.h
//  Box 布局框架
//
//  Created by jxm apple on 16/2/23.
//  Copyright © 2016年 xinggenji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBox : UIView

typedef NS_ENUM(NSInteger, HBoxAlign) {
    HBoxAlignTop,
    HBoxAlignCenter,
    HBoxAlignBottom
};

@property (nonatomic) HBoxAlign boxAlign;
@property (nonatomic) CGFloat lineWidth;

/**
  水平布局管理器(无需设置繁琐的约束，也无需设置frame,自动横向布局)
  功能:
    1.使用权重布局子控件,子控件有大小，优先采用子控件的原大小进行布局,
      没有大小按权重值布局,比如3个子控件可以布局成宽度为1:2:1的效果
    2.可以增加空白,可以增加固定大小的空白，也可以按权重增加空白空间
 
*/
- (void)addSubview:(UIView*)view withWeight:(CGFloat)weight;
- (void)addBlankSpace;
- (void)addBlankSpaceForWidth:(CGFloat)width;
- (void)addBlankSpaceForWeight:(CGFloat)weight;

@end

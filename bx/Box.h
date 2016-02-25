//
//  Box.h
//  Box
//
//  Created by jxm apple on 16/2/23.
//  Copyright © 2016年 xinggenji. All rights reserved.
//  帧布局类，使用此布局类，不用设置xy坐标，只需要设大小即可
//

#import <UIKit/UIKit.h>

@interface Box : UIView

typedef NS_ENUM(NSInteger, BoxValign) {
    BoxValignTop,
    BoxValignBottom,
    BoxValignCenter
};

typedef NS_ENUM(NSInteger, BoxHalign) {
    BoxHalignLeft,
    BoxHalignCenter,
    BoxHalignRight
};

typedef struct Padding {
    CGFloat left, right, top, bottom;
} Padding;

Padding BoxPaddingMake(CGFloat left, CGFloat right, CGFloat top, CGFloat bottom);

@property (nonatomic) BoxValign boxValign;
@property (nonatomic) BoxHalign boxHalign;
@property (nonatomic) Padding padding;

@end

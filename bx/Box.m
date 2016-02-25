//
//  Box.m
//  Box
//
//  Created by jxm apple on 16/2/23.
//  Copyright © 2016年 xinggenji. All rights reserved.
//

#import "Box.h"

@implementation Box

- (void)layoutSubviews

{

    [super layoutSubviews];
    long count = [self.subviews count];

    for (int i = 0; i < count; i++) {
        UIView* view = self.subviews[i];
        CGFloat viewX = 0;
        CGFloat viewY = 0;
        CGFloat viewW = view.frame.size.width;

        CGFloat viewH = view.frame.size.height;

        if (viewW == 0) { //没有宽度
            viewX = self.padding.left;
            viewW = self.frame.size.width - self.padding.right - self.padding.left;
        }
        else if (self.boxHalign == BoxHalignCenter) { //有宽度，居中
            viewX = (self.frame.size.width - self.padding.left - self.padding.right - viewW) / 2;
        }
        else if (self.boxHalign == BoxHalignRight) { //居右
            viewX = (self.frame.size.width - self.padding.left - self.padding.right - viewW);
        }

        if (viewH == 0) { //没有高度
            viewY = self.padding.top;
            viewH = self.frame.size.height - self.padding.top - self.padding.bottom;
        }
        else if (self.boxValign == BoxValignCenter) { //有高度，居中
            viewY = (self.frame.size.height - self.padding.top - self.padding.bottom - viewH) / 2;
        }
        else if (self.boxValign == BoxValignBottom) { //居下
            viewY = (self.frame.size.height - self.padding.top - self.padding.bottom - viewH);
        }

        CGRect viewF = CGRectMake(viewX, viewY, viewW, viewH);

        view.frame = viewF;
    }
}

Padding BoxPaddingMake(CGFloat left, CGFloat right, CGFloat top, CGFloat bottom)
{
    Padding pd;
    pd.left = left;
    pd.right = right;
    pd.top = top;
    pd.bottom = bottom;
    return pd;
}

@end

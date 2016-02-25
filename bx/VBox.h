//
//  VBox
//  VBox.h
//
//  Created by jxm apple on 16/2/23.
//  Copyright © 2016年 xinggenji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VBox : UIView

typedef NS_ENUM(NSInteger, VBoxAlign) {
    VBoxAlignLeft,
    VBoxAlignCenter,
    VBoxAlignRight
};

@property (nonatomic) CGFloat lineHeight;
@property (nonatomic) VBoxAlign boxAlign;

- (void)addSubview:(UIView*)view withWeight:(CGFloat)weight;
- (void)addBlankSpace;
- (void)addBlankSpaceForHeight:(CGFloat)height;
- (void)addBlankSpaceForWeight:(CGFloat)weight;

@end

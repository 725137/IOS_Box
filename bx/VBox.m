//
//  VBox.m
//  VBox
//
//  Created by jxm apple on 16/2/23.
//  Copyright © 2016年 xinggenji. All rights reserved.
//

#import "VBox.h"

@interface BoxWH : NSObject
@property (nonatomic, assign) CGFloat weight;
@property (nonatomic, assign) CGFloat height;
@end

@implementation BoxWH

@end

@interface VBox ()

@property (nonatomic, assign) CGFloat sumWeight;
@property (nonatomic, assign) CGFloat sumHeight;
@property (nonatomic, strong) NSMutableDictionary* objDict;
@property (nonatomic, strong) NSMutableArray* objDicrOrders;

@end

@implementation VBox

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.objDicrOrders = [NSMutableArray array];
        self.objDict = [NSMutableDictionary dictionary];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.objDicrOrders = [NSMutableArray array];
        self.objDict = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)layoutSubviews
{

    [self calcSumHeightAndSumWeight]; //计算总权重和总宽度
    CGFloat currentY = 0;
    CGFloat maxW = CGRectGetWidth(self.frame);

    CGFloat lineWCount = self.lineHeight * ([self.subviews count] - 1);

    CGFloat weightH = (self.frame.size.height - lineWCount - self.sumHeight) / (self.sumWeight == 0 ? 1 : self.sumWeight);

    NSInteger count = [self.objDicrOrders count];

    for (int i = 0; i < count; i++) {

        NSValue* key = self.objDicrOrders[i];

        NSObject* keyObj = [key nonretainedObjectValue];

        if ([keyObj isKindOfClass:[UIView class]]) { //uiView
            UIView* view = (UIView*)keyObj;
            CGFloat viewW = CGRectGetWidth(view.frame);
            CGFloat viewH = CGRectGetHeight(view.frame);

            NSNumber* valueNumber = [self.objDict objectForKey:key];

            CGFloat weight = valueNumber.floatValue;

            viewW = viewW > 0 ? viewW : maxW;
            viewH = viewH > 0 ? viewH : weightH * weight;
            CGFloat viewX = 0;

            if (view != self.subviews[0]) {
                currentY += self.lineHeight;
            }
            if (self.boxAlign == VBoxAlignCenter) {
                viewX = (maxW - viewW) / 2;
            }
            else if (self.boxAlign == VBoxAlignRight) {
                viewX = maxW - viewW;
            }

            view.frame = CGRectMake(viewX, currentY, viewW, viewH);
            currentY += viewH;
        }
        else {
            BoxWH* boxwh = [self.objDict objectForKey:key];

            CGFloat height = boxwh.height;
            CGFloat weight = boxwh.weight;

            currentY += height;
            currentY += weightH * weight;
        }
    }
}

- (void)addSubview:(UIView*)view
{
    [self addSubview:view withWeight:1];
}

- (void)addSubview:(UIView*)view withWeight:(CGFloat)weight
{
    [super addSubview:view];
    NSValue* key = [NSValue valueWithNonretainedObject:view];
    [self.objDict setObject:@(weight) forKey:key];
    [self.objDicrOrders addObject:key];
}

- (void)addBlankSpace
{

    [self addBoxHeight:0 AndWeight:1];
}

- (void)addBlankSpaceForHeight:(CGFloat)height
{
    [self addBoxHeight:height AndWeight:0];
}

- (void)addBlankSpaceForWeight:(CGFloat)weight
{
    [self addBoxHeight:0 AndWeight:weight];
}

- (void)addBoxHeight:(CGFloat)height AndWeight:(CGFloat)weight
{
    BoxWH* boxwh = [[BoxWH alloc] init];
    boxwh.height = height;
    boxwh.weight = weight;

    NSValue* key = [NSValue value:&boxwh withObjCType:@encode(BoxWH)];
    [self.objDict setObject:boxwh forKey:key];
    [self.objDicrOrders addObject:key];
}

- (void)calcSumHeightAndSumWeight
{
    _sumWeight = 0;
    _sumHeight = 0;

    NSInteger count = [self.objDicrOrders count];
    for (int i = 0; i < count; i++) {

        NSValue* key = self.objDicrOrders[i];

        NSObject* keyObj = [key nonretainedObjectValue];

        if ([keyObj isKindOfClass:[UIView class]]) { //uiView
            UIView* view = (UIView*)keyObj;
            CGFloat viewH = CGRectGetHeight(view.frame);

            NSNumber* valueNumber = [self.objDict objectForKey:key];

            CGFloat weight = valueNumber.floatValue;

            if (viewH == 0) {
                _sumWeight += weight;
            }
            _sumHeight += viewH;
        }
        else {
            BoxWH* boxwh = [self.objDict objectForKey:key];

            CGFloat height = boxwh.height;
            CGFloat weight = boxwh.weight;

            _sumHeight += height;
            _sumWeight += weight;
        }
    }
}

@end

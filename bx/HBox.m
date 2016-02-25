//
//  HBox.m
//  HBox
//
//  Created by jxm apple on 16/2/23.
//  Copyright © 2016年 xinggenji. All rights reserved.
//

#import "HBox.h"

@interface BoxWW : NSObject
@property (nonatomic, assign) CGFloat weight;
@property (nonatomic, assign) CGFloat width;
@end

@implementation BoxWW

@end

@interface HBox ()
@property (nonatomic, assign) CGFloat sumWeight;
@property (nonatomic, assign) CGFloat sumWidth;
@property (nonatomic, strong) NSMutableDictionary* objDict;
@property (nonatomic, strong) NSMutableArray* objDicrOrders;
@end

@implementation HBox

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

    [self calcSumWithAndSumWeight]; //计算总权重和总宽度
    CGFloat currentX = 0;
    CGFloat maxH = CGRectGetHeight(self.frame);
    CGFloat lineWCount = self.lineWidth * ([self.subviews count] - 1);

    CGFloat weightW = (self.frame.size.width - lineWCount - self.sumWidth) / (self.sumWeight == 0 ? 1 : self.sumWeight);

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

            viewW = viewW > 0 ? viewW : weightW * weight;
            viewH = viewH > 0 ? viewH : maxH;

            if (view != self.subviews[0]) {
                currentX += self.lineWidth;
            }

            CGFloat viewY = 0;

            if (self.boxAlign == HBoxAlignCenter) {
                viewY = (maxH - viewH) / 2;
            }
            else if (self.boxAlign == HBoxAlignBottom) {
                viewY = maxH - viewH;
            }

            view.frame = CGRectMake(currentX, viewY, viewW, viewH);
            currentX += viewW;
        }
        else {
            BoxWW* boxww = [self.objDict objectForKey:key];

            CGFloat width = boxww.width;
            CGFloat weight = boxww.weight;

            currentX += width;
            currentX += weightW * weight;
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

    [self addBoxWith:0 AndWeight:1];
}

- (void)addBlankSpaceForWidth:(CGFloat)width
{
    [self addBoxWith:width AndWeight:0];
}

- (void)addBlankSpaceForWeight:(CGFloat)weight
{
    [self addBoxWith:0 AndWeight:weight];
}

- (void)addBoxWith:(CGFloat)width AndWeight:(CGFloat)weight
{
    BoxWW* boxww = [[BoxWW alloc] init];
    boxww.width = width;
    boxww.weight = weight;

    NSValue* key = [NSValue value:&boxww withObjCType:@encode(BoxWW)];
    [self.objDict setObject:boxww forKey:key];
    [self.objDicrOrders addObject:key];
}

- (void)calcSumWithAndSumWeight
{
    _sumWeight = 0;
    _sumWidth = 0;

    NSInteger count = [self.objDicrOrders count];
    for (int i = 0; i < count; i++) {

        NSValue* key = self.objDicrOrders[i];

        NSObject* keyObj = [key nonretainedObjectValue];

        if ([keyObj isKindOfClass:[UIView class]]) { //uiView
            UIView* view = (UIView*)keyObj;
            CGFloat viewW = CGRectGetWidth(view.frame);

            NSNumber* valueNumber = [self.objDict objectForKey:key];

            CGFloat weight = valueNumber.floatValue;

            if (viewW == 0) {
                _sumWeight += weight;
            }
            _sumWidth += viewW;
        }
        else {
            BoxWW* boxww = [self.objDict objectForKey:key];

            CGFloat width = boxww.width;
            CGFloat weight = boxww.weight;

            _sumWidth += width;
            _sumWeight += weight;
        }
    }
}

@end

//
//  CircleLineView.h
//  ecmc
//
//  Created by wyong on 11/5/13.
//  Copyright (c) 2013 cp9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleLineView : UIView
{
    CGFloat _degree;//绘图的弧度
    CGFloat _lineWidth;
    UIColor *_strokeGrayColor;
    UIColor *_strokeBlueColor;
    UIColor *_strokeFillColor;
    UIColor *_edgeColor;
}

-(void)drawCircle4Dgree:(CGFloat)deg;

-(void)drawCircle4Dgree:(CGFloat)deg withStrokeColor:(UIColor *)strokeColor withBackgroundStrokeColor:(UIColor *)backgroundColor withFillColor:(UIColor *)fillColor withEdgeColor:(UIColor *)edgeColor;

@end

//
//  CircleLineView.m
//  ecmc
//
//  Created by wyong on 11/5/13.
//  Copyright (c) 2013 cp9. All rights reserved.
//

#import "CircleLineView.h"
#import "UIColor+extend.h"

@implementation CircleLineView

#define startAngles  (0.65*M_PI)

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _degree = 0.0f;
        _lineWidth = 10.0f;
        _strokeBlueColor = [[UIColor getColor:@"007ec5"] retain];
        _strokeGrayColor = [[UIColor getColor:@"d0d0d0"] retain];
        _strokeFillColor = [[UIColor brownColor] retain];
        _edgeColor = [[UIColor redColor] retain];

        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)drawCircle4Dgree:(CGFloat)deg
{
    _degree = deg;
    [self setNeedsDisplay];
}

-(void)drawCircle4Dgree:(CGFloat)deg withStrokeColor:(UIColor *)strokeColor withBackgroundStrokeColor:(UIColor *)backgroundColor withFillColor:(UIColor *)fillColor withEdgeColor:(UIColor *)edgeColor
{
    [_strokeBlueColor release];
    [_strokeGrayColor release];
    [_strokeFillColor release];
    [_edgeColor release];
    _strokeBlueColor = [strokeColor retain];
    _strokeGrayColor = [backgroundColor retain];
    _strokeFillColor = [fillColor retain];
    _edgeColor = [edgeColor retain];
    
    _degree = deg;
    [self setNeedsDisplay];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self drawInContext:UIGraphicsGetCurrentContext()];
}

- (void)drawInContext:(CGContextRef)context
{
//通用
    CGFloat radius = MIN(self.bounds.size.width, self.bounds.size.height)/2.0-10.0f;
    CGPoint center = {self.bounds.size.width/2.0, self.bounds.size.height/2.0};
    
//-------------------------第一种画百分比效果   start-------------------------
//    CGPoint center = {self.bounds.size.width/2.0, self.bounds.size.height/2.0};
//    CGContextBeginPath(context);
//    CGContextSetLineWidth(context, _lineWidth);
//    
//    CGContextMoveToPoint(context, center.x, center.y - radius);
//    CGContextAddArc(context, center.x, center.y, radius, 0-M_PI_2, M_PI*2-M_PI_2, 0);
//    CGContextSetStrokeColorWithColor(context, _strokeGrayColor.CGColor);
//    CGContextStrokePath(context);
//    
//    CGContextAddArc(context, center.x , center.y , radius, 0.7*M_PI, 0.02 + 0.7*M_PI, 0);
//    CGContextSetStrokeColorWithColor(context, _edgeColor.CGColor);
//    CGContextStrokePath(context);
//    UIGraphicsPopContext();
//    
//    CGContextAddArc(context, center.x , center.y , radius, 0.7*M_PI + 0.02, _degree + 0.7*M_PI - 0.02, 0);
//    CGContextSetStrokeColorWithColor(context, _strokeBlueColor.CGColor);
//    CGContextStrokePath(context);
//    UIGraphicsPopContext();
//    
//    CGContextAddArc(context, center.x , center.y , radius, _degree + 0.7*M_PI - 0.02, _degree + 0.7*M_PI, 0);
//    CGContextSetStrokeColorWithColor(context, _edgeColor.CGColor);
//    CGContextStrokePath(context);
//    UIGraphicsPopContext();
//-------------------------第一种画百分比效果     end-------------------------
    
    
//-------------------------第二种画百分比效果   start-------------------------
    UIBezierPath *path=[UIBezierPath bezierPath];
    [path addArcWithCenter:center radius:radius startAngle:0 endAngle:2*M_PI clockwise:NO];

    CAShapeLayer *arcLayer=[CAShapeLayer layer];
    arcLayer.path=path.CGPath;
    arcLayer.fillColor= _strokeFillColor.CGColor;
    arcLayer.strokeColor= _strokeGrayColor.CGColor;
    arcLayer.lineWidth=10;
    [self.layer addSublayer:arcLayer];

    
    UIBezierPath *path1=[UIBezierPath bezierPath];
    [path1 addArcWithCenter:center radius:radius startAngle:startAngles endAngle:startAngles + 0.02 clockwise:YES];
    CAShapeLayer *arcLayers=[CAShapeLayer layer];
    arcLayers.path=path1.CGPath;
    arcLayers.fillColor=[UIColor clearColor].CGColor;
    arcLayers.strokeColor=_edgeColor.CGColor;
    arcLayers.lineWidth=10;
    [self.layer addSublayer:arcLayers];
    
    UIBezierPath *path2=[UIBezierPath bezierPath];
    [path2 addArcWithCenter:center radius:radius startAngle:startAngles + 0.02 endAngle:startAngles + _degree-0.02 clockwise:YES];
    CAShapeLayer *arcLayer2=[CAShapeLayer layer];
    arcLayer2.path=path2.CGPath;
    arcLayer2.fillColor=[UIColor clearColor].CGColor;
    arcLayer2.strokeColor=_strokeBlueColor.CGColor;
    arcLayer2.lineWidth=10;
    [self.layer addSublayer:arcLayer2];
    
    [self drawLineAnimation:arcLayer2];
//-------------------------第二种画百分比效果     end-------------------------
}

-(void)drawLineAnimation:(CALayer*)layer
{
    CABasicAnimation *bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bas.duration=3;
    bas.delegate=self;
    [bas setDelegate:self];
    bas.fromValue=[NSNumber numberWithInteger:0.5];
    bas.toValue=[NSNumber numberWithInteger:1];
    [layer addAnimation:bas forKey:@"key"];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    CGFloat radius = MIN(self.bounds.size.width, self.bounds.size.height)/2.0-10.0f;
    CGPoint center = {self.bounds.size.width/2.0, self.bounds.size.height/2.0};
    
    UIBezierPath *path1=[UIBezierPath bezierPath];
    [path1 addArcWithCenter:center radius:radius startAngle:startAngles + _degree-0.02 endAngle:startAngles + _degree clockwise:YES];
    CAShapeLayer *arcLayers=[CAShapeLayer layer];
    arcLayers.path=path1.CGPath;
    arcLayers.fillColor=[UIColor clearColor].CGColor;
    arcLayers.strokeColor=_edgeColor.CGColor;
    arcLayers.lineWidth=10;
    [self.layer addSublayer:arcLayers];
}

-(void)dealloc
{
    [_strokeGrayColor release];
    [_strokeBlueColor release];
    [_strokeFillColor release];
    [_edgeColor release];
    [super dealloc];
}

@end

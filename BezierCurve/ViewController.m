//
//  ViewController.m
//  BezierCurve
//
//  Created by lyl on 2017/1/19.
//  Copyright © 2017年 LYL. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (nonatomic ,strong) CAShapeLayer * shapeLayer;
@property (nonatomic ,strong) CAShapeLayer * progressLayer;

@property (nonatomic ,strong) NSTimer * timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.shapeLayer    = [CAShapeLayer layer];
    self.progressLayer = [CAShapeLayer layer];
    CGRect drawBounds = CGRectMake(0, 0, 100, 100);
    [self updateLayer:self.shapeLayer Bounds:drawBounds StrockColor:[UIColor redColor]];
    [self updateLayer:self.progressLayer Bounds:drawBounds StrockColor:[UIColor greenColor]];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(circleAnimation) userInfo:nil repeats:YES];
}

- (void)circleAnimation
{
    CGFloat redSpeed   = 0.1;
    CGFloat greenSpeed = redSpeed/2;
    
    if (_shapeLayer.strokeStart == 0 && (_progressLayer.strokeEnd != 0.8 || _shapeLayer.strokeEnd != 1)) {
        if (_shapeLayer.strokeEnd >= 1) {
            redSpeed = 0;
        }
        if (_progressLayer.strokeEnd >= 0.8) {
            greenSpeed = 0;
        }
        self.shapeLayer.strokeEnd += redSpeed;
        self.progressLayer.strokeEnd += greenSpeed;
    }else {
        [_timer invalidate];
    }
}

- (void)updateLayer:(CAShapeLayer *)layer Bounds:(CGRect)bounds StrockColor:(UIColor *)strockColor
{

    layer.frame       = bounds;
    layer.position    = self.view.center;
    layer.fillColor   = [UIColor clearColor].CGColor;
    layer.lineWidth   = bounds.size.width;
    layer.strokeColor = strockColor.CGColor;
    layer.strokeStart = 0;
    layer.strokeEnd   = 0;
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:bounds];
    layer.path        = circlePath.CGPath;
    [self.view.layer addSublayer:layer];
}
- (void)dealloc {
    self.timer = nil;
}


@end

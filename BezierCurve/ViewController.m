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
    [self updateLayer:self.shapeLayer Bounds:drawBounds StrockColor:[UIColor redColor] Start:0.75 End:0.75];
    [self updateLayer:self.progressLayer Bounds:drawBounds StrockColor:[UIColor greenColor] Start:0 End:0];
    
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(circleAnimationTwo) userInfo:nil repeats:YES];
}

/**
 设置layer的香菇你属性
 
 @param layer       ：要进行操作的CAShapeLayer
 @param bounds      ：layer的大小
 @param strockColor ：划线的颜色
 */
- (void)updateLayer:(CAShapeLayer *)layer Bounds:(CGRect)bounds StrockColor:(UIColor *)strockColor Start:(CGFloat)start End:(CGFloat)end
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
/**
    扇形动画1
 */
- (void)circleAnimationOne
{
    CGFloat speed = 0.05;
    if (_progressLayer.strokeEnd <=0.75) {
        _shapeLayer.strokeEnd += speed;
        _progressLayer.strokeEnd += speed;
    }else if (_shapeLayer.strokeEnd <=1){
        _shapeLayer.strokeEnd += speed;
    }else{
        [_timer invalidate];
    }
}
/**
    扇形动画2
 */
- (void)circleAnimationTwo
{
    CGFloat redSpeed   = 0.1;
    CGFloat greenSpeed = redSpeed/2;
    if (_progressLayer.strokeEnd <=0.75) {
        _shapeLayer.strokeEnd += redSpeed;
        _progressLayer.strokeEnd += greenSpeed;
    }else if (_shapeLayer.strokeEnd <=1){
        _shapeLayer.strokeEnd += redSpeed;
    }else{
        [_timer invalidate];
    }
}
/**
    释放Timer
 */
- (void)dealloc {
    self.timer = nil;
}


@end

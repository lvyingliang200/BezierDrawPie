//
//  ViewController.m
//  BezierCurve
//
//  Created by lyl on 2017/1/19.
//  Copyright © 2017年 LYL. All rights reserved.
//

#import "ViewController.h"

#define CENTER self.view.center

@interface ViewController ()

@property (nonatomic ,strong) CAShapeLayer * shapeLayer;
@property (nonatomic ,strong) CAShapeLayer * progressLayer;
@property (nonatomic ,strong) CAShapeLayer * subShapeLayer;
@property (nonatomic ,strong) CAShapeLayer * subProgressLayer;

@property (nonatomic ,assign) CGRect drawBounds;

@property (nonatomic ,strong) NSTimer * timer;

@property (weak, nonatomic) IBOutlet UIButton *animationBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.shapeLayer    = [CAShapeLayer layer];
    self.progressLayer = [CAShapeLayer layer];
    _drawBounds = CGRectMake(0, 0, 100, 100);

    [self drawSubTitleLayerWithPosition:CGPointMake(100, 500) FillColor:[UIColor greenColor] RectRadius:10];
    [self drawSubTitleLayerWithPosition:CGPointMake(200, 500) FillColor:[UIColor redColor] RectRadius:10];
    
}

- (IBAction)startAnimation:(UIButton *)sender
{
    sender.userInteractionEnabled = NO;
    [_shapeLayer removeFromSuperlayer];
    [_progressLayer removeFromSuperlayer];
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:_drawBounds];
    [self updateLayer:self.shapeLayer Bounds:_drawBounds StrockColor:[UIColor redColor] Start:0.75 End:0.75 BezierPath:circlePath Position:CENTER];
    [self updateLayer:self.progressLayer Bounds:_drawBounds StrockColor:[UIColor greenColor] Start:0 End:0 BezierPath:circlePath Position:CENTER];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(circleAnimationOne) userInfo:nil repeats:YES];
    });
}

- (void)drawSubTitleLayerWithPosition:(CGPoint)position FillColor:(UIColor *)fillcolor RectRadius:(CGFloat)radius
{
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    //开始点 从上左下右的点
    [aPath moveToPoint:CGPointMake(position.x,position.y)];
    [aPath addLineToPoint:CGPointMake(position.x + radius, position.y)];
    [aPath addLineToPoint:CGPointMake(position.x + radius, position.y + radius)];
    [aPath addLineToPoint:CGPointMake(position.x , position.y + radius)];
    [aPath closePath];

    CAShapeLayer *shapelayer = [CAShapeLayer layer];
    shapelayer.strokeColor = nil;
    shapelayer.fillColor = fillcolor.CGColor;
    shapelayer.path = aPath.CGPath;
    [self.view.layer addSublayer:shapelayer];
}

/**
 设置layer的相关属性
 
 @param layer       ：要进行操作的CAShapeLayer
 @param bounds      ：layer的大小
 @param strockColor ：划线的颜色
 */
- (void)updateLayer:(CAShapeLayer *)layer Bounds:(CGRect)bounds StrockColor:(UIColor *)strockColor Start:(CGFloat)start End:(CGFloat)end BezierPath:(UIBezierPath*)bezierPath Position:(CGPoint)position
{
    
    layer.frame       = bounds;
    layer.position    = position;
    layer.fillColor   = [UIColor clearColor].CGColor;
    layer.lineWidth   = bounds.size.width;
    layer.strokeColor = strockColor.CGColor;
    layer.strokeStart = 0;
    layer.strokeEnd   = 0;
    layer.path        = bezierPath.CGPath;
    [self.view.layer addSublayer:layer];
}
/**
    扇形动画1
 */
- (void)circleAnimationOne
{
    CGFloat speed = 0.05;
    if (_progressLayer.strokeEnd <=0.80) {
        _shapeLayer.strokeEnd += speed;
        _progressLayer.strokeEnd += speed;
    }else if (_shapeLayer.strokeEnd <=1){
        _shapeLayer.strokeEnd += speed;
    }else{
        [_timer invalidate];
        _animationBtn.userInteractionEnabled = YES;
        
    }
}
/**
    扇形动画2
 */
- (void)circleAnimationTwo
{
    CGFloat redSpeed   = 0.05;
    CGFloat greenSpeed = redSpeed/2;
    if (_progressLayer.strokeEnd <=0.80) {
        _shapeLayer.strokeEnd += redSpeed;
        _progressLayer.strokeEnd += greenSpeed;
    }else if (_shapeLayer.strokeEnd <=1){
        _shapeLayer.strokeEnd += redSpeed;
    }else{
        [_timer invalidate];
        _animationBtn.userInteractionEnabled = YES;
    }
}

/**
    释放Timer
 */
- (void)dealloc {
    self.timer = nil;
}


@end

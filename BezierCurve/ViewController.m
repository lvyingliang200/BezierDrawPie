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

@property (weak, nonatomic) IBOutlet UIButton *animationBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.shapeLayer    = [CAShapeLayer layer];
    self.progressLayer = [CAShapeLayer layer];
}

- (IBAction)startAnimation:(UIButton *)sender
{
    sender.userInteractionEnabled = NO;
    [_shapeLayer removeFromSuperlayer];
    [_progressLayer removeFromSuperlayer];
    CGRect drawBounds = CGRectMake(0, 0, 100, 100);
    [self updateLayer:self.shapeLayer Bounds:drawBounds StrockColor:[UIColor redColor] Start:0.75 End:0.75];
    [self updateLayer:self.progressLayer Bounds:drawBounds StrockColor:[UIColor greenColor] Start:0 End:0];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(circleAnimationOne) userInfo:nil repeats:YES];
    });
    
}

/**
 设置layer的相关属性
 
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

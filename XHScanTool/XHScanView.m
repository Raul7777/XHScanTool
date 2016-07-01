//
//  XHScanView.m
//  XHScanTool
//
//  Created by TianGeng on 16/6/30.
//  Copyright © 2016年 bykernel. All rights reserved.
//

#import "XHScanView.h"
#import <AVFoundation/AVFoundation.h>

@interface XHScanView ()
@property (nonatomic, strong) UIImageView *lineView;
@property (nonatomic, strong) NSTimer *timer;

@end


@implementation XHScanView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    
        // 初始化
       
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    if (!_lineView) {
        self.lineView  = [[UIImageView alloc] init];
        self.lineView.image = [UIImage imageNamed:@"line"];
        self.lineView .frame = CGRectMake((self.frame.size.width - self.showSize.width) / 2, self.center.y - (self.showSize.height)/2, self.showSize.width, 2);
        
        [self addSubview:self.lineView];
        
        _timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(animation) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        
        }
}
- (void)animation
{
    
    self.showSize = (CGSizeEqualToSize(self.showSize, CGSizeZero)) ? CGSizeMake( 200, 200) : self.showSize;
    
//    CGFloat startY = ;
    
    [UIView animateWithDuration:2.9 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{

       self.lineView .frame = CGRectMake((self.frame.size.width - self.showSize.width) / 2, self.center.y + (self.showSize.height)/2, self.showSize.width, 2);
        
    } completion:^(BOOL finished) {
       self.lineView .frame = CGRectMake((self.frame.size.width - self.showSize.width) / 2, self.center.y - (self.showSize.height)/2, self.showSize.width, 2);
    }];
}
- (void)drawRect:(CGRect)rect{
    self.cornerWidth = 15;
    
    self.showSize = (CGSizeEqualToSize(self.showSize, CGSizeZero)) ? CGSizeMake( 200, 200) : self.showSize;
    
    
    //中间清空的矩形框
    CGRect clearDrawRect = CGRectMake(rect.size.width / 2 - self.showSize.width / 2,
                                      rect.size.height / 2 - self.showSize.height / 2,
                                      self.showSize.width,self.showSize.height);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self addScreenFillRect:ctx rect:self.frame];
    
    [self addCenterClearRect:ctx rect:clearDrawRect];
    
    [self addWhiteRect:ctx rect:clearDrawRect];
    
    [self addCornerLineWithContext:ctx rect:clearDrawRect];
    
    
    
}

- (void)addScreenFillRect:(CGContextRef)ctx rect:(CGRect)rect {
    
    CGContextSetRGBFillColor(ctx, 40 / 255.0,40 / 255.0,40 / 255.0,0.5);
    CGContextFillRect(ctx, rect);   //draw the transparent layer
}


- (void)addCenterClearRect :(CGContextRef)ctx rect:(CGRect)rect {
    
    CGContextClearRect(ctx, rect);  //clear the center rect  of the layer
}

- (void)addWhiteRect:(CGContextRef)ctx rect:(CGRect)rect {
    
    CGContextStrokeRect(ctx, rect);
    CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1);
    CGContextSetLineWidth(ctx, 0.8);
    CGContextAddRect(ctx, rect);
    CGContextStrokePath(ctx);
}

- (void)addCornerLineWithContext:(CGContextRef)ctx rect:(CGRect)rect{
    
    //画四个边角
    CGContextSetLineWidth(ctx, 2);
    
    
    CGContextSetRGBStrokeColor(ctx, 83 /255.0, 239/255.0, 111/255.0, 1);//绿色
    
    //左上角
    CGPoint poinsTopLeftA[] = {
        CGPointMake(rect.origin.x+0.7, rect.origin.y),
        CGPointMake(rect.origin.x+0.7 , rect.origin.y + 15)
    };
    
    CGPoint poinsTopLeftB[] = {CGPointMake(rect.origin.x, rect.origin.y +0.7),CGPointMake(rect.origin.x + 15, rect.origin.y+0.7)};
    [self addLine:poinsTopLeftA pointB:poinsTopLeftB ctx:ctx];
    
    //左下角
    CGPoint poinsBottomLeftA[] = {CGPointMake(rect.origin.x+ 0.7, rect.origin.y + rect.size.height - 15),CGPointMake(rect.origin.x +0.7,rect.origin.y + rect.size.height)};
    CGPoint poinsBottomLeftB[] = {CGPointMake(rect.origin.x , rect.origin.y + rect.size.height - 0.7) ,CGPointMake(rect.origin.x+0.7 +15, rect.origin.y + rect.size.height - 0.7)};
    [self addLine:poinsBottomLeftA pointB:poinsBottomLeftB ctx:ctx];
    
    //右上角
    CGPoint poinsTopRightA[] = {CGPointMake(rect.origin.x+ rect.size.width - 15, rect.origin.y+0.7),CGPointMake(rect.origin.x + rect.size.width,rect.origin.y +0.7 )};
    CGPoint poinsTopRightB[] = {CGPointMake(rect.origin.x+ rect.size.width-0.7, rect.origin.y),CGPointMake(rect.origin.x + rect.size.width-0.7,rect.origin.y + 15 +0.7 )};
    [self addLine:poinsTopRightA pointB:poinsTopRightB ctx:ctx];
    
    CGPoint poinsBottomRightA[] = {CGPointMake(rect.origin.x+ rect.size.width -0.7 , rect.origin.y+rect.size.height+ -15),CGPointMake(rect.origin.x-0.7 + rect.size.width,rect.origin.y +rect.size.height )};
    CGPoint poinsBottomRightB[] = {CGPointMake(rect.origin.x+ rect.size.width - 15 , rect.origin.y + rect.size.height-0.7),CGPointMake(rect.origin.x + rect.size.width,rect.origin.y + rect.size.height - 0.7 )};
    [self addLine:poinsBottomRightA pointB:poinsBottomRightB ctx:ctx];
    CGContextStrokePath(ctx);
}

- (void)addLine:(CGPoint[])pointA pointB:(CGPoint[])pointB ctx:(CGContextRef)ctx {
    CGContextAddLines(ctx, pointA, 2);
    CGContextAddLines(ctx, pointB, 2);
}

@end

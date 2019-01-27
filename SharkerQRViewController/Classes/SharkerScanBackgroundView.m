//
//  SharkerScanBackgroundView.m
//  SharkerQRViewController
//
//  Created by didi on 2019/1/27.
//  Copyright © 2019 Sharker. All rights reserved.
//

#import "SharkerScanBackgroundView.h"

@implementation SharkerScanBackgroundView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    if (!CGRectIsEmpty(_clearFrame)) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
//        镂空
        UIBezierPath *blankPath = [UIBezierPath bezierPathWithRect:_clearFrame];
        CGContextSaveGState(context);
        [[UIColor clearColor] setFill];
        [blankPath fillWithBlendMode:kCGBlendModeClear alpha:1];
        CGContextRestoreGState(context);
        
//        边框
        UIBezierPath *borderPath = [UIBezierPath bezierPathWithRect:CGRectMake(_clearFrame.origin.x-5, _clearFrame.origin.y-0.5, _clearFrame.size.width + 1, _clearFrame.size.height + 1)];
        CGContextSaveGState(context);
        borderPath.lineWidth = 0.5;
        [[[UIColor blackColor] colorWithAlphaComponent:0.5] setStroke];
        CGContextRestoreGState(context);
    }
}

- (void)setClearFrame:(CGRect)clearFrame{
    _clearFrame = clearFrame;
    [self setNeedsDisplay];
}


@end

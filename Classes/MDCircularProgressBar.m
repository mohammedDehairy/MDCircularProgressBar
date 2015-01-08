//
//  MDCircularProgressBar.m
//  MDCircularProgressBar Demo
//
//  Created by mohamed mohamed El Dehairy on 1/8/15.
//  Copyright (c) 2015 mohamed mohamed El Dehairy. All rights reserved.
//

#import "MDCircularProgressBar.h"

@implementation MDCircularProgressBar
-(instancetype)initWithCentre:(CGPoint)centre radius:(CGFloat)radius strokeColour:(UIColor*)strockColour fillColour:(UIColor*)fillColour
{
    if(self = [super initWithFrame:CGRectMake(centre.x-radius, centre.y-radius, 2*radius, 2*radius)])
    {
        _progress = 0;
        
        _lineWidth = 5;
        
        //make the view transparent
        self.backgroundColor = [UIColor clearColor];
        
        //save fill colour , stroke colour ,and radius
        _strokColour = strockColour;
        _fillColour  = fillColour;
        _radius = radius;
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithCentre:CGPointMake(CGRectGetMaxX(frame), CGRectGetMaxY(frame)) radius:MIN(frame.size.width, frame.size.height) strokeColour:[UIColor whiteColor] fillColour:[UIColor clearColor]];
}

-(void)setFillColour:(UIColor *)fillColour
{
    //save the new fill colour
    _fillColour = fillColour;
    
    //change progress layer fill colour
    progressLayer.fillColor = _fillColour.CGColor;
}

-(void)setStrokColour:(UIColor *)strokColour
{
    //save the new strok colour
    _strokColour = strokColour;
    
    //change progress layer stroke colour
    progressLayer.strokeColor = _strokColour.CGColor;
}

-(void)setProgress:(CGFloat)progress
{
    //set progress
    _progress = progress;
    [self setNeedsDisplay];
    
    
    //if progress less than 1.0 show the progress
    if(progress < 1.0)
    {
        [self.layer removeAnimationForKey:@"flashAnimation"];
    }
    
    //if progress finished hide th progress layer
    if(progress >= 1.0)
    {
        [CATransaction begin];
        CABasicAnimation *flash = [CABasicAnimation animationWithKeyPath:@"opacity"];
        flash.fromValue = [NSNumber numberWithFloat:1.0];
        flash.toValue = [NSNumber numberWithFloat:0.0];
        flash.duration = 0.3;
        flash.autoreverses = NO;
        flash.fillMode = kCAFillModeForwards;
        flash.removedOnCompletion = NO;
        flash.repeatCount = 1;
        
        
        
        [CATransaction setCompletionBlock:^(void){
            
            progressLayer.strokeEnd = 0.0;
            
        }];
        
        [self.layer addAnimation:flash forKey:@"flashAnimation"];
        [CATransaction commit];
    }
}

-(void)drawRect:(CGRect)rect
{
    //start angle
    CGFloat angle = -M_PI/2;
    
    //end angle
    CGFloat endAngle = angle + 2*M_PI*_progress;
    
    //pie center
    CGPoint pathCenter = CGPointMake(_radius, _radius);
    
    //start path
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //move to centre
    [path moveToPoint:pathCenter];
    
    //add line to start point at 12 o'clock
    [path addLineToPoint:CGPointMake(pathCenter.x + (_radius-_lineWidth) * cosf(angle), pathCenter.y + (_radius-_lineWidth) * sinf(angle))];
    
    //add arc to the end point
    [path addArcWithCenter:pathCenter radius:_radius-_lineWidth startAngle:angle endAngle:endAngle clockwise:YES];
    
    //close the path so a line drawn to the centre again
    [path closePath];
    
    //set the _fillColour as the pie fill colour
    [_fillColour setFill];
    
    //fill the pie
    [path fill];
    
    
    
    
    
    
    //initialise the circular hollow path
    UIBezierPath *circularPath = [UIBezierPath bezierPathWithArcCenter:pathCenter radius:_radius-_lineWidth startAngle:angle endAngle:endAngle clockwise:YES];
    
    //set _strokColour as the circl stroke colour
    [_strokColour setStroke];
    
    //set line width
    [circularPath setLineWidth:_lineWidth];
    
    //stroke the circular path
    [circularPath stroke];
    
    
}



@end

//
//  MDCircularProgressBar.h
//  MDCircularProgressBar Demo
//
//  Created by mohamed mohamed El Dehairy on 1/8/15.
//  Copyright (c) 2015 mohamed mohamed El Dehairy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDCircularProgressBar : UIView
{
    @private CAShapeLayer *progressLayer;
    @private CGFloat _progress;
    @private CGFloat _radius;
    
}
@property(nonatomic,retain)UIColor *strokColour;
@property(nonatomic,retain)UIColor *fillColour;
@property(nonatomic)CGFloat lineWidth;

-(instancetype)initWithCentre:(CGPoint)centre radius:(CGFloat)radius strokeColour:(UIColor*)strockColour fillColour:(UIColor*)fillColour;

-(void)setProgress:(CGFloat)progress;
@end

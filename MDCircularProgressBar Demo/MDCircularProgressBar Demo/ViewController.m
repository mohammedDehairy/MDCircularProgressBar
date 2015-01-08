//
//  ViewController.m
//  MDCircularProgressBar Demo
//
//  Created by mohamed mohamed El Dehairy on 1/8/15.
//  Copyright (c) 2015 mohamed mohamed El Dehairy. All rights reserved.
//

#import "ViewController.h"
#import "MDCircularProgressBar.h"

@interface ViewController ()
{
    MDCircularProgressBar *progessView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    progessView = [[MDCircularProgressBar alloc] initWithCentre:CGPointMake(160,250) radius:120 strokeColour:[UIColor blackColor] fillColour:[UIColor greenColor]];
    
    progessView.lineWidth = 30;
    [self.view addSubview:progessView];
    
    
    
    
}

-(IBAction)startProgress:(id)sender
{
    [timer invalidate];
    timer = nil;
    
    timerCounter = 0;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    

}

-(void)updateProgress
{
    timerCounter += 0.01;
    
    CGFloat progress = (CGFloat)timerCounter/2;
    
    [progessView setProgress:progress];
    
    if(progress >= 1.0)
    {
        [timer invalidate];
        timer = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

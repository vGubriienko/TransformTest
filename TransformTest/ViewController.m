//
//  ViewController.m
//  TransformTest
//
//  Created by Viktor Gubriienko on 06.02.13.
//  Copyright (c) 2013 Viktor Gubriienko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (IBAction)clickImage:(UIButton *)sender;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[_buttons valueForKey:@"imageView"] setValue:@(UIViewContentModeScaleAspectFit) forKey:@"contentMode"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickImage:(UIButton *)sender {

    CGRect fromRect = sender.frame;
    CGRect toRect = CGRectMake(10.0f, 10.0f, 300.0f, 200.0f);
    
    UIImageView *testImageView = [[UIImageView alloc] initWithImage:[sender imageForState:UIControlStateNormal]];
    testImageView.backgroundColor = [UIColor brownColor];
    testImageView.contentMode = UIViewContentModeScaleAspectFit;
    testImageView.tag = 100;
    
    CGAffineTransform transfrom = [self translatedAndScaledTransformUsingViewRect:toRect fromRect:fromRect];
    
    testImageView.frame = fromRect;
    [self.view addSubview:testImageView];
    
    [UIView animateWithDuration:2 animations:^{
        testImageView.transform = transfrom;
    }];
    
    
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:recognizer];
    [_buttons setValue:@NO forKey:@"enabled"];
}

- (void)handleTap:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        UIView *testView = [self.view viewWithTag:100];
        [testView removeFromSuperview];
        [self.view removeGestureRecognizer:sender];
        [_buttons setValue:@YES forKey:@"enabled"];
    }
}

- (CGAffineTransform)translatedAndScaledTransformUsingViewRect:(CGRect)viewRect fromRect:(CGRect)fromRect {
    float xtransl = viewRect.origin.x - fromRect.origin.x;
    float ytransl = viewRect.origin.y - fromRect.origin.y;
    //float xScale = viewRect.size.width / fromRect.size.width;
    //float yScale = viewRect.size.height / fromRect.size.height;
    
    NSLog(@"xtransl %f, ytransl %f", xtransl, ytransl);
    
    
    CGAffineTransform rectScale = CGAffineTransformMakeScale(viewRect.size.width / fromRect.size.width,
                                                             viewRect.size.height / fromRect.size.height);
    
    CGPoint orig = CGPointMake(fromRect.origin.x, fromRect.origin.y);
    CGPoint newOrig = CGPointApplyAffineTransform(orig, rectScale);
    
    
    return CGAffineTransformMake(viewRect.size.width / fromRect.size.width,
                                 0,
                                 0,
                                 viewRect.size.height / fromRect.size.height,
                                 viewRect.origin.x - newOrig.x,
                                 viewRect.origin.y - newOrig.y);
}

    
@end

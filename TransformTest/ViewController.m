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
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageViews;

@end

@implementation ViewController {
    CGRect _originalRect;
}

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

    _originalRect = sender.frame;
    
    CGFloat aspect = sender.frame.size.width / 300.0f;
    CGRect toRect = CGRectMake(10.0f, 10.0f, 300.0f, sender.frame.size.height / aspect);
    
    UIImage *image = [_imageViews[[_buttons indexOfObject:sender]] image];
    
    UIImageView *testImageView = [[UIImageView alloc] initWithImage:image];
    //testImageView.backgroundColor = [UIColor brownColor];
    testImageView.contentMode = UIViewContentModeScaleAspectFit;
    testImageView.tag = 100;
    
    CGAffineTransform transfrom = [self translatedAndScaledTransformUsingViewRect:toRect fromRect:_originalRect];
    
    testImageView.frame = _originalRect;
    [self.view addSubview:testImageView];
    
    [UIView animateWithDuration:1 animations:^{
        testImageView.transform = transfrom;
    }];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:recognizer];
    [_buttons setValue:@NO forKey:@"enabled"];
}

- (void)handleTap:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        UIView *testView = [self.view viewWithTag:100];
        [self.view removeGestureRecognizer:sender];
        
        
        [UIView animateWithDuration:1 animations:^{
            testView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [testView removeFromSuperview];
            [_buttons setValue:@YES forKey:@"enabled"];
        }];
    }
}

- (CGAffineTransform)translatedAndScaledTransformUsingViewRect:(CGRect)viewRect fromRect:(CGRect)fromRect {
    
    CGSize scales = CGSizeMake(viewRect.size.width/fromRect.size.width, viewRect.size.height/fromRect.size.height);
    CGPoint offset = CGPointMake(CGRectGetMidX(viewRect) - CGRectGetMidX(fromRect), CGRectGetMidY(viewRect) - CGRectGetMidY(fromRect));
    return CGAffineTransformMake(scales.width, 0, 0, scales.height, offset.x, offset.y);

}

    
@end

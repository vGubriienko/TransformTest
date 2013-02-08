//
//  ViewController.m
//  TransformTest
//
//  Created by Viktor Gubriienko on 06.02.13.
//  Copyright (c) 2013 Viktor Gubriienko. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Transformation.h"

@interface ViewController ()

- (IBAction)clickImage:(UIButton *)sender;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageViews;

@end

@implementation ViewController {
    CGAffineTransform _transform;
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

    CGFloat aspect = sender.frame.size.width / 300.0f;
    CGRect originalRect = CGRectMake(10.0f, 10.0f, 300.0f, sender.frame.size.height / aspect);
    CGRect smallRect = sender.frame;
    
    UIImage *image = [_imageViews[[_buttons indexOfObject:sender]] image];
    
    UIImageView *testImageView = [[UIImageView alloc] initWithImage:image];
    //testImageView.backgroundColor = [UIColor brownColor];
    testImageView.contentMode = UIViewContentModeScaleAspectFit;
    testImageView.tag = 100;
    
    _transform = [self.view translatedAndScaledTransformUsingViewRect:smallRect fromRect:originalRect];
    
    testImageView.frame = originalRect;
    [self.view addSubview:testImageView];
    
    testImageView.transform = _transform;
    
    [UIView animateWithDuration:1 animations:^{
        testImageView.transform = CGAffineTransformIdentity;
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
            testView.transform = _transform;
        } completion:^(BOOL finished) {
            [testView removeFromSuperview];
            [_buttons setValue:@YES forKey:@"enabled"];
        }];
    }
}

@end

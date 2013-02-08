//
//  UIView+Transformation.m
//  TransformTest
//
//  Created by Viktor Gubriienko on 08.02.13.
//  Copyright (c) 2013 Viktor Gubriienko. All rights reserved.
//

#import "UIView+Transformation.h"

@implementation UIView (Transformation)

- (CGAffineTransform)translatedAndScaledTransformUsingViewRect:(CGRect)viewRect fromRect:(CGRect)fromRect {
    
    CGSize scales = CGSizeMake(viewRect.size.width/fromRect.size.width, viewRect.size.height/fromRect.size.height);
    CGPoint offset = CGPointMake(CGRectGetMidX(viewRect) - CGRectGetMidX(fromRect), CGRectGetMidY(viewRect) - CGRectGetMidY(fromRect));
    return CGAffineTransformMake(scales.width, 0, 0, scales.height, offset.x, offset.y);
    
}

@end

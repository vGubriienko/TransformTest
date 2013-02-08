//
//  UIView+Transformation.h
//  TransformTest
//
//  Created by Viktor Gubriienko on 08.02.13.
//  Copyright (c) 2013 Viktor Gubriienko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Transformation)

- (CGAffineTransform)translatedAndScaledTransformUsingViewRect:(CGRect)viewRect fromRect:(CGRect)fromRect;

@end

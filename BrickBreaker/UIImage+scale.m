//
//  UIImage+scale.m
//  BrickBreaker
//
//  Created by Hefang Li on 10/17/14.
//  Copyright (c) 2014 J Hastwell. All rights reserved.
//

#import "UIImage+scale.h"

@implementation UIImage (scale)

- (UIImage*)scaleToSize:(CGFloat)length
{
    CGFloat scalePara = self.size.width / length;
    UIImage *scaledImage = [UIImage imageWithCGImage:(__bridge CGImageRef)(self)
                                               scale:(self.scale * scalePara)
                                         orientation:(self.imageOrientation)];
    return scaledImage;
}

@end

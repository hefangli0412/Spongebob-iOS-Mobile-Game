//
//  BBUtil.m
//  SpongebobMobileGame
//
//  Created by Hefang Li on 10/21/14.
//  Copyright (c) 2014 J Hastwell. All rights reserved.
//

#import "BBUtil.h"

@implementation BBUtil

+ (NSInteger) randomWithMin:(NSInteger)min max:(NSInteger)max
{
    return arc4random()%(max - min) + min;
}

@end

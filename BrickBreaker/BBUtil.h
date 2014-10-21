//
//  BBUtil.h
//  SpongebobMobileGame
//
//  Created by Hefang Li on 10/21/14.
//  Copyright (c) 2014 J Hastwell. All rights reserved.
//

#import <Foundation/Foundation.h>

static const uint32_t kPaddleCategory = 0x1 << 1;
static const uint32_t kEdgeCategory   = 0x1 << 2;
static const uint32_t kBrickCategory = 0x1 << 3;
static const uint32_t kFallCategory  = 0x1 << 4;
static const uint32_t kBallCategory   = 0x1 << 0;

static const int kFinalLevelNumber = 3;

@interface BBUtil : NSObject

+ (NSInteger) randomWithMin:(NSInteger)min max:(NSInteger)max;

@end

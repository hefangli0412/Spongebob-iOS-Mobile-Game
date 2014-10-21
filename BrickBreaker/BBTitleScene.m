//
//  BBTitleScene.m
//  BrickBreaker
//
//  Created by Hefang Li on 10/20/14.
//  Copyright (c) 2014 J Hastwell. All rights reserved.
//

#import "BBTitleScene.h"
#import <AVFoundation/AVFoundation.h>
#import "BBMyScene.h"

@implementation BBTitleScene
{
    SKSpriteNode *_backgroundImage;
    AVPlayer *_player;
    SKVideoNode *_videoNode;
    SKSpriteNode *_stopButton;
    SKLabelNode *_buttonText;
}


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size])
    {
        /* Setup your scene here */
        
        SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:@"bg_1"];
        bg.size = self.frame.size;
        bg.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        bg.name = @"BACKGROUND";
        _backgroundImage = bg;
        [self addChild:bg];

        // Setup stopButton
        UIColor *myColor = [UIColor colorWithRed:51.0f/255.0f green:102.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
        _stopButton = [SKSpriteNode spriteNodeWithColor:myColor size:CGSizeMake(100, 40)];
        _stopButton.name = @"Stop Button";
        _stopButton.position = CGPointMake(155, 130);
        [self addChild:_stopButton];
        
        _buttonText = [SKLabelNode labelNodeWithFontNamed:@"Futura"];
        _buttonText.name = @"Stop Button";
        _buttonText.text = @"ENTER";
        _buttonText.position = CGPointMake(0, 0);
        _buttonText.fontColor = [SKColor whiteColor];
        _buttonText.fontSize = 20;
        _buttonText.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        [_stopButton addChild:_buttonText];
        
        // Setup movie
        NSURL *fileURL = [NSURL fileURLWithPath: [[NSBundle mainBundle] pathForResource:@"introvideo" ofType:@"mp4"]];
        _player = [AVPlayer playerWithURL: fileURL];
        _videoNode = [[SKVideoNode alloc] initWithAVPlayer:_player];
        _videoNode.size = CGSizeMake(270, 205);
        _videoNode.position = CGPointMake(160, 280);
        _player.allowsExternalPlayback = YES;
        [self addChild:_videoNode];
        _player.volume = 1;
        [_videoNode play];
        
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInNode:self];
    SKSpriteNode *touchedNode = (SKSpriteNode*)[self nodeAtPoint:touchPoint];

    if ([touchedNode.name isEqualToString:@"Stop Button"] ) {
        [_videoNode pause];
        
        BBMyScene * scene = [BBMyScene sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition moveInWithDirection:SKTransitionDirectionRight duration:1.0];
        [self.view presentScene:scene transition:transition];
    }
}





@end

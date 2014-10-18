//
//  BBMenu.m
//  BrickBreaker
//
//  Created by J Hastwell on 23/04/2014.
//  Copyright (c) 2014 J Hastwell. All rights reserved.
//

#import "BBMenu.h"

@implementation BBMenu
{
    SKSpriteNode *_menuPanel;
    SKLabelNode *_panelText;
    SKSpriteNode *_playButton;
    SKLabelNode *_buttonText;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _menuPanel = [SKSpriteNode spriteNodeWithImageNamed:@"MenuPanel_1"];
        _menuPanel.position = CGPointZero;
        [self addChild:_menuPanel];
        
        _panelText = [SKLabelNode labelNodeWithFontNamed:@"Futura"];
        _panelText.text = @"LEVEL 1";
        _panelText.fontColor = [SKColor whiteColor];
        _panelText.fontSize = 15;
        _panelText.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        [_menuPanel addChild:_panelText];
        
        
        _playButton = [SKSpriteNode spriteNodeWithImageNamed:@"sandy_3"];
        _playButton.name = @"Play Button";
        _playButton.position = CGPointMake(0, -((_menuPanel.size.height * 0.5) + (_playButton.size.height * 0.5) + 10));
        SKAction *rotate1 = [SKAction rotateByAngle:0.15 duration:0.85];
        SKAction *rotate2 = [SKAction rotateByAngle:-0.15 duration:0.85];
        SKAction *rotate = [SKAction sequence:@[rotate1, rotate2]];
        SKAction *repeateRotate = [SKAction repeatActionForever:rotate];
        [_playButton runAction:repeateRotate];
        [self addChild:_playButton];
        
        _buttonText = [SKLabelNode labelNodeWithFontNamed:@"Futura"];
        _buttonText.name = @"Play Button";
        _buttonText.text = @"PLAY";
        _buttonText.position = CGPointMake(0, 6);
        _buttonText.fontColor = [SKColor redColor];
        _buttonText.fontSize = 15;
        _buttonText.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        [_playButton addChild:_buttonText];
        
    }
    return self;
}

-(void)setLevelNumber:(int)levelNumber
{
    _levelNumber = levelNumber;
    _panelText.text = [NSString stringWithFormat:@"LEVEL %d", levelNumber];
}


-(void)show
{
    SKAction *slideLeft = [SKAction moveByX:-260.0 y:0.0 duration:0.5];
    slideLeft.timingMode = SKActionTimingEaseOut;
    SKAction *slideRight = [SKAction moveByX:260.0 y:0.0 duration:0.5];
    slideRight.timingMode = SKActionTimingEaseOut;
    
    _menuPanel.position = CGPointMake(260, _menuPanel.position.y);
    _playButton.position = CGPointMake(-260, _playButton.position.y);
    
    [_menuPanel runAction:slideLeft];
    [_playButton runAction:slideRight];
    
    self.hidden = NO;
    
}

-(void)hide
{
    SKAction *slideLeft = [SKAction moveByX:-260.0 y:0.0 duration:0.5];
    slideLeft.timingMode = SKActionTimingEaseIn;
    SKAction *slideRight = [SKAction moveByX:260.0 y:0.0 duration:0.5];
    slideRight.timingMode = SKActionTimingEaseIn;
    
    _menuPanel.position = CGPointMake(0, _menuPanel.position.y);
    _playButton.position = CGPointMake(0, _playButton.position.y);
    
    [_menuPanel runAction:slideLeft];
    [_playButton runAction:slideRight completion:^{
        self.hidden = YES;
    }];
}


@end











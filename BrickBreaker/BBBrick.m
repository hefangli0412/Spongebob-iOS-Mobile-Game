//
//  BBBrick.m
//  BrickBreaker
//
//  Created by J Hastwell on 17/04/2014.
//  Copyright (c) 2014 J Hastwell. All rights reserved.
//

#import "BBBrick.h"
#import "BBUtil.h"

@implementation BBBrick
{
    SKAction *_brickSmashSound;
}


-(instancetype)initWithType:(BrickType)type
{
    
    switch (type) {
        case Green:
            {self = [super initWithColor:[UIColor whiteColor] size:CGSizeMake(42, 35)];
            NSArray *textures = @[[SKTexture textureWithImageNamed:@"gary_1"],
                                  [SKTexture textureWithImageNamed:@"gary_2"]];
            SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.5];
            [self runAction:[SKAction repeatActionForever:animation]];
            break;}
        case Blue:
            {self = [super initWithColor:[UIColor whiteColor] size:CGSizeMake(42, 35)];
            NSArray *textures = @[[SKTexture textureWithImageNamed:@"Spongebob_1"],
                                  [SKTexture textureWithImageNamed:@"Spongebob_2"]];
            SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.5];
            [self runAction:[SKAction repeatActionForever:animation]];
            SKAction *scale = [SKAction resizeToWidth:0.8 * self.size.width height:self.size.height duration:0];
            [self runAction:scale];
            break;}
        case Grey:
            {self = [super initWithColor:[UIColor whiteColor] size:CGSizeMake(42, 35)];
            NSArray *textures = @[[SKTexture textureWithImageNamed:@"krab_3"],
                                  [SKTexture textureWithImageNamed:@"krab_4"]];
            SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.5];
            [self runAction:[SKAction repeatActionForever:animation]];
            SKAction *scale = [SKAction resizeToWidth:0.9 * self.size.width height:self.size.height duration:0];
            [self runAction:scale];
            break;}
        case Yellow:
            {self = [super initWithColor:[UIColor whiteColor] size:CGSizeMake(42, 35)];
            NSArray *textures = @[[SKTexture textureWithImageNamed:@"Patrick_star_3"],
                                  [SKTexture textureWithImageNamed:@"Patrick_star_4"]];
            SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.5];
            [self runAction:[SKAction repeatActionForever:animation]];
            SKAction *scale = [SKAction resizeToWidth:0.9 * self.size.width height:self.size.height duration:0];
            [self runAction:scale];
            break;}
        default:
            self = nil;
            break;
    }
    
    if (self) {
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.categoryBitMask = kBrickCategory;
        self.physicsBody.dynamic = NO;
        self.type = type;
        self.indestructible = (type == Grey);
        self.spawnsExtraBall = (type == Yellow);
        
        _brickSmashSound = [SKAction playSoundFileNamed:@"BrickSmash.caf" waitForCompletion:NO];
        
    }
    
    return self;
}


-(void)hit
{
    switch (self.type)
    {
        case Green:
            [self createExplosion];
            [self runAction:_brickSmashSound];
            [self runAction:[SKAction removeFromParent]];
            break;
        
        case Yellow:
            [self createExplosion];
            [self runAction:_brickSmashSound];
            [self runAction:[SKAction removeFromParent]];
            break;
            
        case Blue:
            {
                NSArray *textures = @[[SKTexture textureWithImageNamed:@"gary_1"],
                                  [SKTexture textureWithImageNamed:@"gary_2"]];
                SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.5];
                [self runAction:[SKAction repeatActionForever:animation]];
                SKAction *scale = [SKAction resizeToWidth:self.size.width/0.8 height:self.size.height   duration:0];
                [self runAction:scale];
                self.type = Green;
                break;
            }
        default:
            {
                // Grey bricks are indestructible.
                SKSpriteNode *enemyNode = [SKSpriteNode spriteNodeWithImageNamed:@"plank_2"];
                enemyNode.position = self.position;
                [self.parent addChild:enemyNode];
                enemyNode.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:10];
                enemyNode.physicsBody.categoryBitMask = kFallCategory;
                enemyNode.physicsBody.contactTestBitMask = kPaddleCategory | kEdgeCategory;
                enemyNode.physicsBody.velocity = CGVectorMake([BBUtil randomWithMin:kEnemyMinSpeedX max:kEnemyMaxSpeedX], [BBUtil randomWithMin:kEnemyMinSpeedY max:kEnemyMaxSpeedY]);
                
                [enemyNode runAction:[SKAction waitForDuration:3.0] completion:^{
                    [enemyNode removeFromParent];
                }];
                break;
            }
    }
}

-(void)createExplosion
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"BrickExplosion" ofType:@"sks"];
    SKEmitterNode *explosion = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    explosion.position = self.position;
    [self.parent addChild:explosion];
    
    SKAction *removeExplosion = [SKAction sequence:@[[SKAction waitForDuration:explosion.particleLifetime + explosion.particleLifetimeRange],
                                                     [SKAction removeFromParent]]];
                                 
    [explosion runAction:removeExplosion];
}


@end














//
//  GameScene.m
//  FlappyClone
//
//  Created by Michael Vilabrera on 8/4/15.
//  Copyright (c) 2015 Giving Tree. All rights reserved.
//

#import "GameScene.h"

@interface GameScene() {
    SKSpriteNode *_bird;
    SKColor *_skyColor;
}

@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
    // add sky
    _skyColor = [SKColor colorWithRed:113.0/255.0 green:197.0/255.0 blue:207.0/255.0 alpha:1.0];
    [self setBackgroundColor:_skyColor];
    
    // Create ground
    SKTexture *groundTexture = [SKTexture textureWithImageNamed:@"Ground"];
    groundTexture.filteringMode = SKTextureFilteringNearest;
    
    SKAction *moveGroundSprite = [SKAction moveByX:-groundTexture.size.width * 2 y:0 duration:0.02 * groundTexture.size.width * 2];
    SKAction *resetGroundSprite = [SKAction moveByX:groundTexture.size.width * 2 y:0 duration:0];
    SKAction *moveGroundSpritesForever = [SKAction repeatActionForever:[SKAction sequence:@[moveGroundSprite, resetGroundSprite]]];
    
    for (int i = 0; i < 2 + self.frame.size.width / (groundTexture.size.width * 2); i++) {
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:groundTexture];
        [sprite setScale:2.0];
        sprite.position = CGPointMake(i * sprite.size.width, sprite.size.height / 2);
        [sprite runAction:moveGroundSpritesForever];
        [self addChild:sprite];
    }
    
    // Create skyline
    SKTexture *skylineTexture = [SKTexture textureWithImageNamed:@"Skyline"];
    skylineTexture.filteringMode = SKTextureFilteringNearest;
    
    SKAction *moveSkylineSprite = [SKAction moveByX:-skylineTexture.size.width * 2 y:0 duration:0.1 * skylineTexture.size.width * 2];
    SKAction *resetSkylineSprite = [SKAction moveByX:skylineTexture.size.width * 2 y:0 duration:0];
    SKAction *moveSkylineSpriteForever = [SKAction repeatActionForever:[SKAction sequence:@[moveSkylineSprite, resetSkylineSprite]]];
    
    for (int i = 0; i < 2 + self.frame.size.width / (skylineTexture.size.width * 2); i++) {
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:skylineTexture];
        [sprite setScale:2.0];
        sprite.zPosition = -20;
        sprite.position = CGPointMake(i * sprite.size.width, sprite.size.height / 2 + groundTexture.size.height * 2);
        [sprite runAction:moveSkylineSpriteForever];
        [self addChild:sprite];
    }
    
    // The Bird is the Word
    SKTexture *birdTexture1 = [SKTexture textureWithImageNamed:@"Bird1"];
    birdTexture1.filteringMode = SKTextureFilteringNearest;
    
    SKTexture *birdTexture2 = [SKTexture textureWithImageNamed:@"Bird2"];
    birdTexture2.filteringMode = SKTextureFilteringNearest;
    
    SKAction *flap = [SKAction repeatActionForever:[SKAction animateWithTextures:@[birdTexture1, birdTexture2] timePerFrame:0.2]];
    
    _bird = [SKSpriteNode spriteNodeWithTexture:birdTexture1];
    [_bird setScale:2.0];
    _bird.position = CGPointMake(self.frame.size.width/4, CGRectGetMidY(self.frame));
    
    [self addChild:_bird];
    [_bird runAction:flap];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end

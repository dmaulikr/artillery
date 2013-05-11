//
//  GameplayScene.m
//  Artillery
//
//  Created by Marcin Kuptel on 27/04/13.
//
//

#import "GameplayScene.h"
#import "BackgroundLayer.h"
#import "GameplayLayer.h"

@implementation GameplayScene

- (id) init
{
    self = [super init];
    if (self) {
        
        _backgroundLayer = [[BackgroundLayer alloc] init];
        [self addChild: _backgroundLayer];
        
        _gameplayLayer = [[GameplayLayer alloc] init];
        [self addChild: _gameplayLayer];
    }
    return self;
}

@end

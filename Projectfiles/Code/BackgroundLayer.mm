//
//  BackgroundLayer.m
//  Artillery
//
//  Created by Marcin Kuptel on 27/04/13.
//
//

#import "BackgroundLayer.h"

@implementation BackgroundLayer

- (id) init
{
    self = [super init];
    if (self) {
        CCDirector *director = [CCDirector sharedDirector];
        
        CCSprite *backgroundSprite = [CCSprite spriteWithFile: @"background.png"];
        backgroundSprite.size = director.winSize;
        backgroundSprite.position = director.screenCenter;
        [self addChild: backgroundSprite];
    }
    return self;
}

@end

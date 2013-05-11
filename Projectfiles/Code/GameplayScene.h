//
//  GameplayScene.h
//  Artillery
//
//  Created by Marcin Kuptel on 27/04/13.
//
//

#import "CCScene.h"

@class BackgroundLayer;
@class GameplayLayer;

@interface GameplayScene : CCScene {
    BackgroundLayer *_backgroundLayer;
    GameplayLayer *_gameplayLayer;
}

@end

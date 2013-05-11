//
//  GameplayLayer.h
//  Artillery
//
//  Created by Marcin Kuptel on 27/04/13.
//
//

#import "CCLayer.h"
#import "Box2D.h"
#import "GLES-Render.h"

@class Canon;

@interface GameplayLayer : CCLayer <CCTouchOneByOneDelegate>{
    @private
    b2World *_world;
    GLESDebugDraw* _debugDraw;
    Canon *_canon;
}

@end

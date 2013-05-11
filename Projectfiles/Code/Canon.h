//
//  Canon.h
//  Artillery
//
//  Created by Marcin Kuptel on 28/04/13.
//
//

#import "BodySprite.h"

@interface Canon : CCSpriteBatchNode {
    @private
    BodySprite *_barrel;
    BodySprite *_wheel;
    b2RevoluteJoint *joint;
}

@property (nonatomic, assign) float barrelAngle;
@property (nonatomic, assign) BOOL barrelStatic;

+ (id) canonWithWorld: (b2World*) world position: (CGPoint) position;

@end

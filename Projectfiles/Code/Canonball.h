//
//  Canonball.h
//  Artillery
//
//  Created by Marcin Kuptel on 30/04/13.
//
//

#import "BodySprite.h"

@interface Canonball : BodySprite

+ (id) canonballWithWorld: (b2World*) world position: (CGPoint) position;

@end

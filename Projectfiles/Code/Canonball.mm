//
//  Canonball.m
//  Artillery
//
//  Created by Marcin Kuptel on 30/04/13.
//
//

#import "Canonball.h"

@implementation Canonball

+ (id) canonballWithWorld: (b2World*) world position: (CGPoint) position
{
    return [[self alloc] initWithWorld: world position: position];
}


- (id) initWithWorld: (b2World*) world position: (CGPoint) position
{
    self = [super initWithShape: @"canonball" inWorld: world];
    if (self) {
        
        //self.position = position;
        
        self.physicsBody->SetTransform([Helper toMeters: position], 0);
        self.physicsBody->SetType(b2_dynamicBody);
    }
    return self;
}


@end

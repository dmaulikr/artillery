//
//  Canon.m
//  Artillery
//
//  Created by Marcin Kuptel on 28/04/13.
//
//

#import "Canon.h"

@implementation Canon


- (id) initWithWorld: (b2World*) world position: (CGPoint) position
{
    self = [super initWithFile: @"gameLayer.png" capacity: 10];
    if (self) {
        
        self.position = position;
        
        _wheel = [[BodySprite alloc] initWithShape: @"wheel" inWorld: world];
        _wheel.physicsBody->SetTransform([Helper toMeters: position], 0);
        _wheel.physicsBody->SetType(b2_staticBody); //bodies are static by default
        [self addChild: _wheel z: -2];
        
        _barrel = [[BodySprite alloc] initWithShape: @"barrel" inWorld: world];
        
        _barrel.physicsBody->SetTransform([Helper toMeters: position], 0);
        _barrel.physicsBody->SetType(b2_dynamicBody);
        [self addChild: _barrel z: -3];
        
        //add a revolute joint
        b2RevoluteJointDef jointDef;
        jointDef.Initialize(_wheel.physicsBody, _barrel.physicsBody, _wheel.physicsBody->GetWorldCenter());
//        jointDef.lowerAngle = -0.0f * b2_pi;
//        jointDef.upperAngle = 0.25f * b2_pi;
        jointDef.maxMotorTorque = 200.0f;
        jointDef.motorSpeed = 40.0f;
        //jointDef.enableMotor = true;
//        jointDef.enableLimit = true;
        joint = (b2RevoluteJoint*)world->CreateJoint(&jointDef);
    }
    return self;
}


+ (id) canonWithWorld: (b2World*) world position: (CGPoint) position
{
    return [[self alloc] initWithWorld: world position: position];
}


#pragma mark - Accessors

- (void) setBarrelAngle:(float)angle
{
    
    float correctAngle = angle - CC_DEGREES_TO_RADIANS(35);
    
    _barrel.physicsBody->SetTransform(_barrel.physicsBody->GetPosition(), correctAngle);
}


- (void) setBarrelStatic:(BOOL)barrelStatic
{
    if (barrelStatic) {
        _barrel.physicsBody->SetType(b2_staticBody);
    }else{
        _barrel.physicsBody->SetType(b2_dynamicBody);
    }
}

@end

//
//  GameplayLayer.m
//  Artillery
//
//  Created by Marcin Kuptel on 27/04/13.
//
//

#import "GameplayLayer.h"
#import "Helper.h"
#import "Canon.h"
#import "Canonball.h"

@implementation GameplayLayer

- (id) init
{
    self = [super init];
    if (self) {
        
        // pre load the sprite frames from the texture atlas
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"gameLayer.plist"];
		
        // load physics definitions
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"physics-ipadhd.plist"];
        
        [self initPhysics];
        [self addCannon];
        
        //add touch delegate
        [[CCDirector sharedDirector].touchDispatcher addTargetedDelegate: self
                                                                priority: 0
                                                         swallowsTouches: NO];
        
        [self scheduleUpdate];
    }
    return self;
}


- (void) dealloc
{
    delete _world;
    _world = NULL;
    delete _debugDraw;
    _debugDraw = NULL;
}

- (void) cleanup
{
    [super cleanup];
    
    [[CCDirector sharedDirector].touchDispatcher removeDelegate: self];
}


- (void) initPhysics
{
    //create world
    b2Vec2 gravity;
    gravity.Set(0.0f, -15.0f);
    _world = new b2World(gravity);
    _world->SetAllowSleeping(true);
    _world->SetContinuousPhysics(true);
    
    _debugDraw = new GLESDebugDraw(PTM_RATIO);
	_world->SetDebugDraw(_debugDraw);
	
	uint32 flags = 0;
	flags += b2Draw::e_shapeBit;
	flags += b2Draw::e_jointBit;
	//		flags += b2Draw::e_aabbBit;
	//		flags += b2Draw::e_pairBit;
	//		flags += b2Draw::e_centerOfMassBit;
	_debugDraw->SetFlags(flags);
    
    //create ground body
    b2BodyDef groundBodyDef;
    groundBodyDef.position.Set(0.0f, 0.0f);
    b2Body *groundBody = _world->CreateBody(&groundBodyDef);
    
    //create fixture
    CGSize screenSize = [CCDirector sharedDirector].winSize;
	float boxWidth = screenSize.width / PTM_RATIO;
	float boxHeight = screenSize.height / PTM_RATIO;
    
    b2EdgeShape edge;
    edge.Set(b2Vec2(0, 48/PTM_RATIO), b2Vec2(boxWidth, 48/PTM_RATIO));
    b2Fixture *bottom = groundBody->CreateFixture(&edge, 0.0f);
    
    edge.Set(b2Vec2(boxWidth, boxHeight), b2Vec2(boxWidth, 48/PTM_RATIO));
    b2Fixture *right = groundBody->CreateFixture(&edge, 0.0f);
    
    edge.Set(b2Vec2(0, boxHeight), b2Vec2(boxWidth, boxHeight));
    b2Fixture *top = groundBody->CreateFixture(&edge, 0.0f);
    
    edge.Set(b2Vec2(0, 0), b2Vec2(0, boxHeight));
    b2Fixture *left = groundBody->CreateFixture(&edge, 0.0f);
    
    b2Filter collisonFilter;
    collisonFilter.groupIndex = 0;
    collisonFilter.categoryBits = 0x0004;
    collisonFilter.maskBits = 0x000d;
    
    bottom->SetFilterData(collisonFilter);
    right->SetFilterData(collisonFilter);
    top->SetFilterData(collisonFilter);
    left->SetFilterData(collisonFilter);
}


- (void) addCannon
{
    _canon = [Canon canonWithWorld: _world position: ccp(100, 70)];
    [self addChild: _canon];
}


#pragma mark - Touches


- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    [_canon setBarrelStatic: YES];
    CGPoint location = [Helper locationFromTouch: touch];
    [self setCanonAngleForTouchLocation: location];
    
    //add canonball
    [self addCanonballAtLocation: location];
    
    return YES;
}


- (void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [Helper locationFromTouch: touch];
    [self setCanonAngleForTouchLocation: location];
}


- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    [_canon setBarrelStatic: NO];
}


- (void) setCanonAngleForTouchLocation: (CGPoint) location
{
    CGFloat a = location.y - _canon.position.y;
    CGFloat b = location.x - _canon.position.x;
    
    float angle = atanf(a/b);
    
    if (angle > 0 && angle < M_PI/2) {
        [_canon setBarrelAngle: angle];
    }
}


- (void) addCanonballAtLocation: (CGPoint) location
{
    Canonball *canonball = [Canonball canonballWithWorld: _world position: location];
    [self addChild: canonball];
    
    canonball.physicsBody->ApplyLinearImpulse(b2Vec2(50, 50), canonball.physicsBody->GetWorldCenter());
}


#pragma mark - Update

- (void) update:(ccTime)delta
{
    int velocityIterations = 8;
    int positionIterations = 3;
    _world->Step(delta, velocityIterations, positionIterations);
}


#if DEBUG
-(void) draw
{
	[super draw];
	
	ccGLEnableVertexAttribs(kCCVertexAttribFlag_Position);
	kmGLPushMatrix();
	_world->DrawDebugData();
	kmGLPopMatrix();
}
#endif

@end
 
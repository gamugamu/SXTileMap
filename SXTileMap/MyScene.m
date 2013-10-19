//
//  MyScene.m
//  SX_Test
//
//  Created by Abadie Loic on 19/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "MyScene.h"
#import "SXMapAtlas.h"

@interface MyScene()
@property(nonatomic, strong)SXMapAtlas* mapAtlas;
@end

@implementation MyScene

#pragma mark ============================ public ===============================
#pragma mark ===================================================================

- (id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.mapAtlas = [self createMapAtlas];
        [self testMapAtlas: _mapAtlas];
        
        self.backgroundColor = [SKColor whiteColor];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

#pragma mark ============================ private ==============================
#pragma mark ===================================================================

#pragma mark - setup

- (SXMapAtlas*)createMapAtlas{
   return [SXMapAtlas mapAtlasWithDescription: nil];
}

#pragma mark - logic

- (void)testMapAtlas:(SXMapAtlas*)mapAtlas{
    [self addChild: mapAtlas];
}

@end

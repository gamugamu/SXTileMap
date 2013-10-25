//
//  MyScene.m
//  SX_Test
//
//  Created by Abadie Loic on 19/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "MyScene.h"
#import "SXMapAtlas.h"
#import "SXMapAtlasDescription.h"
#import "SXMapTile.h"

@interface MyScene()
@end

@implementation MyScene

#pragma mark ============================ public ===============================
#pragma mark ===================================================================

- (id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        [self testMapAtlas];
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

- (void)testMapAtlas{
    // note that rgb.png is not what a file is. For the moment we are still under development.
    SXMapAtlas* mapAtlas = [SXMapAtlas mapAtlasWithDescription: [SXMapAtlasDescription mapAtlasDescription: @"rgb.png"]];
    mapAtlas.xScale = .5f;
    mapAtlas.yScale = .5f;
    mapAtlas.position = CGPointMake(50, 100);
    SXMapTile* tile = [mapAtlas tileAtPoint:(SXPoint){4, 4}];
    
    tile.sprite.alpha = .5;
    tile.textureId = 0;
    
    [self addChild: mapAtlas];
}

#pragma mark - logic


@end

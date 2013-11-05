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
#import "SXTilesLayer.h"
#import "SX2DMatrice.h"

@interface MyScene()
@property(nonatomic, strong)SXMapAtlas* mapAtlas;
@end

@implementation MyScene
@synthesize mapAtlas = _mapAtlas;

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
    self.mapAtlas = [SXMapAtlas mapAtlasWithDescription: [SXMapAtlasDescription mapAtlasDescription: @"rgb.png"]];
    _mapAtlas.xScale    = .5f;
    _mapAtlas.yScale    = .5f;
    _mapAtlas.position  = CGPointMake(50, 100);

    [self addChild: _mapAtlas];
    
    NSError* __autoreleasing error = nil;
    SX2DMatrice* matrix = [[SX2DMatrice alloc] initWith2DMatrix: @[@[@24, @24, @5, @5],
                                                                   @[@12, @12, @12, @12]]
                                                        onError: &error];
    NSLog(@"error %@ - %@", error, matrix);
    
    SXTilesLayer* layer = [_mapAtlas allLayers][0];
    [layer changeTilesTextureIdWith2DMatrix: matrix];
    
    //[self changeTexture];
}

- (void)changeTexture{
    static int count    = 0;
    SXMapTile* tile     = [[_mapAtlas allLayers][0] tileAtPoint:(SXPoint){4, 4}];
    tile.textureId      = ++count;
    
    [self performSelector: @selector(changeTexture)
               withObject: nil
               afterDelay: 1];
}

#pragma mark - logic


@end

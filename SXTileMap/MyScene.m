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

#import "SXConverser.h"

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
    SXMapAtlasDescription* description = [SXMapAtlasDescription mapAtlasDescriptionFromRessourceFolder: @"media_2"];
    
    self.mapAtlas = [SXMapAtlas mapAtlasWithDescription: description];
    
    _mapAtlas.xScale    = .25f;
    _mapAtlas.yScale    = .25f;
    _mapAtlas.position  = CGPointMake(150, 300);

    [self addChild: _mapAtlas];
    
   // NSError* __autoreleasing error = nil;
   
  /*  SX2DMatrice* matrix = [[SX2DMatrice alloc] initWith2DMatrix: @[@[@24, @24, @5, @5],
                                                                   @[@12, @12, @12, @12]]
                                                        onError: &error];
    */
   // SXTilesLayer* layer = [_mapAtlas allLayers][0];
   // [layer changeTilesTextureIdWith2DMatrix: matrix];
    
   // [self changeTexture];
}

- (void)changeTexture{
    static int count    = 0;
    SXMapTile* tile     = [[_mapAtlas allLayers][0] tileAtPoint:(SXPoint){0, 0}];
    tile.textureId      = ++count;
    
    [self performSelector: @selector(changeTexture)
               withObject: nil
               afterDelay: 1];
    NSLog(@"change");
}

#pragma mark - logic


@end

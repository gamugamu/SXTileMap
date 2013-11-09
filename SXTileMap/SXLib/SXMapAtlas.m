//
//  SXMapAtlas.m
//  SXTileMap
//
//  Created by Abadie Loic on 19/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "SXMapAtlas.h"
#import "SXTilesLayer.h"
#import "SXTilesLayer_private.h"

@interface SXMapAtlas()
@property(nonatomic, strong)NSArray* allLayers;
@end

@implementation SXMapAtlas
@synthesize allLayers               = _allLayers,
            currenSpaceCoordinate   = _currenSpaceCoordinate;

#pragma mark ============================ public ===============================
#pragma mark ===================================================================

+ (SXMapAtlas*)mapAtlasWithDescription:(SXMapAtlasDescription*)data{
    return [[SXMapAtlas alloc] initWithDescription: data];
}

- (id)initWithDescription:(SXMapAtlasDescription*)description{
    if(self = [super init]){
        [self setUpLayers: (void*)description];
    }
    return self;
}

- (NSArray*)allTiles{
    return nil;
}

- (NSArray*)tilesFromRegion:(void*)region{
    return nil;
}

#pragma mark - getter / setter

- (void)setCurrenSpaceCoordinate:(SXCoordinateSpace)currenSpaceCoordinate{
    if(currenSpaceCoordinate != _currenSpaceCoordinate){
    
    }
}

#pragma mark - override

- (CGRect)calculateAccumulatedFrame{
    // note: should take care. Not implemented Yet.
    return CGRectMake(0, 0, 0, 0);
}


#pragma mark ============================ private ==============================
#pragma mark ===================================================================

- (void)setUpLayers:(void*)layerDescription{
    SXTilesLayer* simpleLayer   = [[SXTilesLayer alloc] initTilesLayerWithLayerDescription: layerDescription];
    simpleLayer.mapAtlas        = self;
    
    SXTilesLayer* simpleLayer_2   = [[SXTilesLayer alloc] initTilesLayerWithLayerDescription: layerDescription];
    simpleLayer_2.mapAtlas        = self;

    self.allLayers = @[simpleLayer];
    [self addChild: simpleLayer];
    [self addChild: simpleLayer_2];
}

@end

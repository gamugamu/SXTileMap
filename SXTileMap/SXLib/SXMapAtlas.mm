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
#import "SXMapAtlasDescription_private.h"

@interface SXMapAtlas()
@property(nonatomic, strong)NSMutableArray* allLayers;
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
        [self setUpMap: description];
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

#pragma mark - setup

- (void)setUpMap:(SXMapAtlasDescription*)mapDescription{
    NSMutableArray* listLayers = [NSMutableArray array];
    
    for (int i = 0; i < [mapDescription layersCount]; i++) {
        SXTilesLayer* tileLayer = [self createLayers: mapDescription withId: i];
        
        [listLayers addObject: tileLayer];
        [self addChild: tileLayer];
    }
    
    self.allLayers = listLayers;
}

- (SXTilesLayer*)createLayers:(SXMapAtlasDescription*)mapDescription withId:(uint)layerId{
    SXTilesLayer* simpleLayer   = [[SXTilesLayer alloc] initTilesLayerWithLayerDescription: mapDescription
                                                                                   layerId: layerId];
    simpleLayer.mapAtlas        = self;
    NSLog(@"create layer %@", simpleLayer);
    return simpleLayer;
}

@end

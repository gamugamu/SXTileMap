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
    const _SXMapDescription* des = mapDescription.data;
    printf("get ---> %u\n", des->layersCount);
    for (int i = 0; i < des->layersCount; i++) {
        printf("%p\n", des->layers + i);
        _SXTilesLayerDescription* const test = des->layers + i;
        printf("XXX %u [%u %u]\n", test->layerId, test->sizeGrid.row, test->sizeGrid.column);
        [self setUpLayers: mapDescription withId: test->layerId];
    }
}

- (void)setUpLayers:(SXMapAtlasDescription*)mapDescription withId:(uint)layerId{
    SXTilesLayer* simpleLayer   = [[SXTilesLayer alloc] initTilesLayerWithLayerDescription: mapDescription
                                                                                   layerId: layerId];
    simpleLayer.mapAtlas        = self;

    self.allLayers = @[simpleLayer];
    [self addChild: simpleLayer];
}

@end

//
//  SXTilesLayer.m
//  SXTileMap
//
//  Created by Abadie, Loïc on 05/11/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "SXTilesLayer.h"
#import "SXMapTile.h"
#import "SXMapTile_hidden.h"
#import "SXMapTileBuilder.h"

@interface SXTilesLayer()
@property(nonatomic, strong)SXMapTileBuilder* mapBuilder;
@end

@implementation SXTilesLayer
@synthesize mapBuilder = _mapBuilder;

#pragma mark -------------------------- public ---------------------------------
#pragma mark -------------------------------------------------------------------

- (id)initTilesLayerWithLayerDescription:(void*)description{
    if(self = [super init]){
        [self setUpMapBuilder: (__bridge SXMapAtlasDescription*)description];
        [self setUpTiles: (__bridge SXMapAtlasDescription*)description fromBuilder: _mapBuilder];
        [self displayTiles: _mapBuilder.allGeneratedTiles];
    }
    return self;
}

- (SXMapTile*)tileAtPoint:(SXPoint)pnt{
    return [_mapBuilder tileAtPoint: pnt];
}

- (NSArray*)allTiles{
    return nil;
}

- (NSArray*)tilesFromRegion:(void*)region{
    return nil;
}

#pragma mark -------------------------- private --------------------------------
#pragma mark -------------------------------------------------------------------

#pragma mark - hidden

- (void)changeMapTile:(SXMapTile*)mapTile withTextureId:(TRId)textureId{
    [_mapBuilder changeMapTile: mapTile withTextureId: textureId];
}

#pragma mark - setUp

- (void)setUpMapBuilder:(SXMapAtlasDescription*)description{
    self.mapBuilder = [[SXMapTileBuilder alloc] initFromDescription: description];
}

- (void)setUpTiles:(SXMapAtlasDescription*)description
       fromBuilder:(SXMapTileBuilder*)builder{
    /* Note that it should be deported elseWhere */
    [builder generateTile];
}

#pragma mark - displayLogic

- (void)displayTiles:(NSArray*)tilesList{
    for(SXMapTile* tiles in tilesList){
        tiles.layer = self;
        [self addChild: tiles.sprite];
    }
}

@end

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
#import "SX2DMatrice_hidden.h"
#import "SXMapTileBuilder.h"
#import <vector>

@interface SXTilesLayer()
@property(nonatomic, strong)SXMapTileBuilder* mapBuilder;
@end

using namespace std;

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

- (void)changeTilesTextureIdWith2DMatrix:(SX2DMatrice*)matrix2d{
    vector<vector<unsigned> > m = [matrix2d getRawMatrixCopy];
    [self changeTileTextureFromMatrix: m];
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

- (void)changeTileTextureFromMatrix:(const vector<vector<unsigned> >&)m{
    // Note that it is poorly designed. Improvement will be made later if necessary.
    for (int i = 0; i < m.size(); ++i) {
        for(int j = 0; j < m[i].size(); ++j){
            SXMapTile* tile = [self tileAtPoint:(SXPoint){static_cast<uint_fast8_t>(i),
                                                          static_cast<uint_fast8_t>(j)}];
            NSLog(@"get tile %@ %u", tile,  m[i][j]);
            
            tile.textureId = m[i][j];
        }
    }
}
@end

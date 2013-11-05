//
//  SXTilesLayer.h
//  SXTileMap
//
//  Created by Abadie, Loïc on 05/11/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import <SpriteKit/SKNode.h>
#import "SXTypes.h"

@class SXMapTile;

//----------------------------------------------------------------------------//
// SXTilesLayer holds collection of tiles.
//----------------------------------------------------------------------------//
@interface SXTilesLayer : SKNode

/**
    Should be hidden.
 */
- (id)initTilesLayerWithLayerDescription:(void*)description;

/**
    Return a tile from the mapAtlas coordinate system.
    Return nil, if that tile doens't exit.
 */
- (SXMapTile*)tileAtPoint:(SXPoint)pnt;

/**
    Return a list of tiles from a region.
    Return only tiles from valid position.
 */
- (NSArray*)tilesFromRegion:(void*)region;

/**
    Return all Tiles
 */
- (NSArray*)allTiles;

@end

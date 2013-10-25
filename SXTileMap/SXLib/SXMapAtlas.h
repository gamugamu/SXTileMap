//
//  SXMapAtlas.h
//  SXTileMap
//
//  Created by Abadie Loic on 19/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import <SpriteKit/SKNode.h>
#import "SXMapAtlasDescription.h" // for SXPoint

@class SXMapTile;
@class SXMapAtlasDescription;

//----------------------------------------------------------------------------//
// SXMapAtlas holds collection of tiles.
//----------------------------------------------------------------------------//
@interface SXMapAtlas : SKNode

/**
    Create a mapAtlas
 */
+ (SXMapAtlas*)mapAtlasWithDescription:(SXMapAtlasDescription*)data;

/**
    Create a mapAtlas
 */
- (id)initWithDescription:(SXMapAtlasDescription*)data;

/**
    Return a tile from the mapAtlas coordinate system.
    Return nil, if that tile doens't exit.
 */
- (SXMapTile*)tileAtPoint:(SXPoint)pnt;

/**
    Return all Tiles
 */
- (NSArray*)allTiles;

/**
    Return an array of tiles from a region
 */
- (NSArray*)tilesFromRegion:(void*)region;

@end

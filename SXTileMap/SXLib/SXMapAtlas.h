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

+ (SXMapAtlas*)mapAtlasWithDescription:(SXMapAtlasDescription*)data;
- (id)initWithDescription:(SXMapAtlasDescription*)data;

- (SXMapTile*)tileAtPoint:(SXPoint)pnt;
- (NSArray*)allTiles;
- (NSArray*)tilesFromRegion:(void*)region;

@end

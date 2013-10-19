//
//  SXMapAtlas.h
//  SXTileMap
//
//  Created by Abadie Loic on 19/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SXMapTile;
//----------------------------------------------------------------------------//
// SXMapAtlas holds collection of tiles.
//----------------------------------------------------------------------------//
@interface SXMapAtlas : NSObject

- (SXMapAtlas*)mapAtlas;
- (SXMapAtlas*)mapAtlasWithDescription:(void*)data;

- (SXMapTile*)mapTileAtPoint:(void*)pnt;
- (NSArray*)mapTiles;
- (NSArray*)mapTilesFromRegion;

@end

//
//  SXMutableMapAtlas.h
//  SXTileMap
//
//  Created by Abadie Loic on 19/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "SXMapAtlas.h"

//----------------------------------------------------------------------------//
// SXMapAtlas holds a mutable collection of tiles.
//----------------------------------------------------------------------------//
@interface SXMutableMapAtlas : SXMapAtlas

- (void)addTileAtPoint:(void*)pnt;
- (void)removeTileAtPoint:(void*)pnt;

- (void)addTilesFromRegion:(void*)region;
- (void)removeTilesFromRegion:(void*)region;

- (void)addTilesFromColumn:(void*)region;
- (void)addTilesFromRow:(void*)region;

- (void)removeTilesFromColumn:(void*)column;
- (void)removeTilesFromRow:(void*)row;

@end

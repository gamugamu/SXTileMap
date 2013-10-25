//
//  SXMapTileBuilder.h
//  SXTileMap
//
//  Created by Abadie Loic on 19/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXMapAtlasDescription.h" // for SXPoint

@class SXMapTile;
@class SXMapAtlasDescription;

//----------------------------------------------------------------------------//
// SXMapTileBuilder know how to build tiles.
//----------------------------------------------------------------------------//
@interface SXMapTileBuilder : NSObject

/**
    Create a MapTile builder
 */
- (SXMapTileBuilder*)initFromDescription:(SXMapAtlasDescription*)mapDescription;

/**
    Generate all the tiles from the SXMapAtlasDescription*.
 */
- (void)generateTile;

/**
    Return the tiles at the Map coordinate system. Return nil if can't be found. 
 */
- (SXMapTile*)tileAtPoint:(SXPoint)pnt;

/**
    Change the texture of the tile by another one. Change are made with the same
    texture file tile sprite. Don't change the texture if the TRId is unknow.
 */
- (void)changeMapTile:(SXMapTile*)mapTile withTextureId:(TRId)textureId;

/**
    All the tiles that the SXMapTileMap has created. Return nil if allGeneratedTiles
    has not be claaed.
 */
@property(nonatomic, readonly)NSArray* allGeneratedTiles;
@end

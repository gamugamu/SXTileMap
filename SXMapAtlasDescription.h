//
//  SXMapAtlasDescription.h
//  SXTileMap
//
//  Created by Abadie Loic on 19/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import <Foundation/Foundation.h>

//----------------------------------------------------------------------------//
// SXMapAtlasDescription define what is a MapAtlas file.
//----------------------------------------------------------------------------//

// A with and height of a mapGrid.
typedef struct{
    uint_fast8_t row;
    uint_fast8_t column;
}_SXGridSize;

// Represent the size of all tiles into a SXMapAtlas. They are all of the same
// size. Note that a square is not required to be a square size.
typedef struct{
    uint_fast8_t width;
    uint_fast8_t height;
}_SXTileSize;

// Represent the coordinate system.
typedef struct{
    uint_fast8_t x;
    uint_fast8_t y;
}_SXPoint;

typedef struct{
    UInt32 tid;         // a unique id for each tile.
    _SXPoint position;   // where the tile is into the map coordinate.
}_SXTile;

typedef struct{
    _SXGridSize sizeGrid;
    _SXTileSize sizeTile;
    void** tiles;
}_SXMapDescription;

// **** Note: they must be opaque and hidden from the implementation.

@interface SXMapAtlasDescription : NSObject

+ (id)mapAtlasDescription:(NSString*)fileName;

@property(nonatomic, readonly)NSString* fileName;
// opaque data
@property(nonatomic, assign /* readonly en prod */)void* data;
@end

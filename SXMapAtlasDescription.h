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
}SXGridSize;

// Represent the size of all tiles into a SXMapAtlas. They are all of the same
// size. Note that a square is not required to be a square size.
typedef struct{
    uint_fast8_t row;
    uint_fast8_t column;
}SXTileSize;

// Represent the coordinate system.
typedef struct{
    uint_fast8_t x;
    uint_fast8_t y;
}SXPoint;

typedef struct{
    UInt32 tid;         // a unique id for each tile.
    SXPoint position;   // where the tile is into the map coordinate.
}SXTile;

typedef struct{
    SXGridSize sizeGrid;
    SXTileSize sizeTile;
    void** tiles;
}mapDescription;

// **** Note: they must be opaque and hidden from the implementation.

@interface SXMapAtlasDescription : NSObject

+ (id)mapAtlasDescription:(NSString*)fileName;
// opaque data
@property(nonatomic, assign /* readonly en prod */)void* data;
@end

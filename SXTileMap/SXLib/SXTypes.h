//
//  SXTypes.h
//  SXTileMap
//
//  Created by Abadie, Loïc on 25/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#ifndef SXTileMap_SXTypes_h
#define SXTileMap_SXTypes_h

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

typedef CGRect SXRect;

// Texture region id
typedef unsigned TRId;

typedef _SXGridSize matrixSize;

// Represent the coordinate system.
typedef struct{
    uint_fast8_t x;
    uint_fast8_t y;
}SXPoint;

typedef struct{
    unsigned tileId;              // a unique id for each tile.
    TRId    textureRegionId;    // an id representing the region of the texture.
    SXPoint position;           // where the tile is into the map coordinate.
}_SXTileDescription;

// Represent the coordinate space. By default bottomLeft.
typedef enum{
    SXCoordinateBottomLeft,
    SXCoordinateBottomRight,
    SXCoordinateTopLeft,
    SXCoordinateTopRight
}SXCoordinateSpace;

typedef struct{
    _SXGridSize sizeGrid;
    _SXTileSize sizeTile;
    void** tiles;
}_SXMapDescription;

#endif

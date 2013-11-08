//
//  SXTypes.h
//  SXTileMap
//
//  Created by Abadie, Loïc on 25/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#ifndef SXTileMap_SXTypes_h
#define SXTileMap_SXTypes_h

typedef CGRect SXRect;

// Texture region id
typedef unsigned TRId;

typedef struct{
    uint_fast8_t row;
    uint_fast8_t column;
}SXMatrixSize;

// Represent the coordinate system.
typedef struct{
    uint_fast8_t x;
    uint_fast8_t y;
}SXPoint;

// Represent the coordinate space. By default bottomLeft.
typedef enum{
    SXCoordinateBottomLeft,
    SXCoordinateBottomRight,
    SXCoordinateTopLeft,
    SXCoordinateTopRight
}SXCoordinateSpace;

#endif

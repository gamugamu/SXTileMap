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
typedef int TRId;

typedef struct{
    unsigned row;
    unsigned column;
}SXMatrixSize;

// Represent the Map Atlas coordinate system.
typedef struct{
    unsigned x;
    unsigned y;
}SXPoint;

// Represent the coordinate space. By default bottomLeft.
typedef enum{
    SXCoordinateBottomLeft,
    SXCoordinateBottomRight,
    SXCoordinateTopLeft,
    SXCoordinateTopRight
}SXCoordinateSpace;

// Represent a tile without any trid.
extern const int SXBlankTileTRID;
// a blank Rect.
extern const SXRect SXBlankRect;

#endif

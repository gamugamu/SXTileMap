//
//  SXTypes_private.h
//  SXTileMap
//
//  Created by Abadie, Loïc on 05/11/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#ifndef SXTileMap_SXTypes_private_h
#define SXTileMap_SXTypes_private_h

#import "SXTypes.h"

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

typedef struct{
    unsigned tileId;            // a unique id for each tile.
    TRId    textureRegionId;    // an id representing the region of the texture.
    SXPoint position;           // where the tile is into the map coordinate.
}_SXTileDescription;

struct _SXMapDescription;

typedef struct{
    _SXGridSize sizeGrid;                              // Because a layer grid can be smaller than his mapAtlas grid.
    struct _SXMapDescription* const mapDescription;    // A pointer to the mapDescription.
    TRId* TRID_list;                                    // An opaque list of trid. Designed to fill the layer of tiles.
}_SXTilesLayerDescription;

typedef struct _SXMapDescription{
    _SXGridSize sizeGrid;
    _SXTileSize sizeTile;
    unsigned layersCount;                  // Number of layer.
    _SXTilesLayerDescription* layers;      // Layers description
}_SXMapDescription;

// Those types are forward declared because they use c++ template.
// Defined in SXTypes_encodage.hh

struct decodedMapData;      // an opaque decoded mapData type.
struct decodedLayerData;    // an opaque decoded LayerData type.

#endif

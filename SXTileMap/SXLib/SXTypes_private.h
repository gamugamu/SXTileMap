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
#include <vector>
#include <string>

// A with and height of a mapGrid.
typedef struct{
    unsigned row;
    unsigned column;
}_SXGridSize;

// Represent the size of all tiles into a SXMapAtlas. They are all of the same
// size. Note that a square is not required to be a square size.
typedef struct{
    unsigned width;
    unsigned height;
}_SXTileSize;

typedef struct{
    unsigned tileId;                                    // a unique id for each tile.
    TRId    textureRegionId;                            // an id representing the region of the texture.
    SXPoint position;                                   // where the tile is into the map coordinate.
}_SXTileDescription;

struct _SXMapDescription;

struct _SXTilesLayerDescription{
    _SXGridSize sizeGrid;                               // Because a layer grid can be smaller than his mapAtlas grid.
    _SXMapDescription*  mapDescription;                 // A pointer to the mapDescription.
    unsigned index;
    std::string textureName;
    std::vector<TRId> TRID_list;                        // An list of trid. Designed to fill the layer of tiles.
                                                        // hold sizeGrid.row * sizeGrid.column
};

struct _SXMapDescription{
    _SXGridSize sizeGrid;
    _SXTileSize sizeTile;
    unsigned layersCount;                              // Number of layer.
    std::vector<_SXTilesLayerDescription*> layers;     // Layers description
};

// Those types are forward declared because they use c++ template.
// Defined in SXTypes_encodage.hh

struct decodedMapData;                                  // an opaque decoded mapData type.
struct decodedLayerData;                                // an opaque decoded LayerData type.

#endif

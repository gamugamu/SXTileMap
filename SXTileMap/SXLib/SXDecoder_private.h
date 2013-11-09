//
//  SXDecoder_hidden.h
//  SXTileMap
//
//  Created by loïc Abadie on 09/11/2013.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#ifndef SXTileMap_SXDecoder_hidden_h
#define SXTileMap_SXDecoder_hidden_h

#include <vector>
#include <string>
#include "SXDecoder.h"

struct decodedLayerData{
    std::string layerTextureFile;
    _SXGridSize layerSize;
    unsigned level;
    std::vector<int> layerRepresentation;
};

struct decodedMapData{
    _SXGridSize gridSize;
    _SXTileSize tileSize;
    std::vector<const struct decodedLayerData> allDataLayers;
};

inline void logMapData(decodedMapData& mapData){
    printf("gridSize %u %u\n", mapData.gridSize.row, mapData.gridSize.column);
    printf("gridSize %u %u\n", mapData.tileSize.width, mapData.tileSize.height);
    
    for(const struct decodedLayerData& layer : mapData.allDataLayers){
        printf("layer %u\n", layer.level);
        printf("layerTexture %s\n", layer.layerTextureFile.c_str());
        printf("layer Size %u %u\n", layer.layerSize.row, layer.layerSize.column);
        
        for (int i = 0;  i < layer.layerSize.row; i++) {
            for (int j = 0;  j < layer.layerSize.column; j++) {
                printf("%u", layer.layerRepresentation[i * layer.layerSize.column + j]);
            }
            printf("\n");
        }
    }
    printf("\n");
}

@interface SXDecoder()
/**
     Decode a map and return a decodedMapData representation.
     @param data
     An opaque data 
 */
+ (struct decodedMapData)decodeMapData:(char*)data;

@end

#endif
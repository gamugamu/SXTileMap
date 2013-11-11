//
//  SXDecoderToMapDescription.c
//  SXTileMap
//
//  Created by loïc Abadie on 10/11/2013.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#include <stdio.h>
#include "SXDecoderToMapDescription.h"
#include "SXTypes_private.h"
#include "SXDecoder_private.h"

#pragma mark -------------------------- public ---------------------------------
#pragma mark -------------------------------------------------------------------

#pragma alloc / dealloc

void sxInitAndConvertDecodedToMapDescription(const _SXDecodedMapData* data, _SXMapDescription* desc){
    size_t totalLayer    = data->allDataLayers.size();
    desc->layers         = std::vector<_SXTilesLayerDescription*>(totalLayer);
    desc->layersCount    = totalLayer;
    desc->sizeGrid       = data->gridSize;
    desc->sizeTile       = data->tileSize;

    for (int i = 0; i < totalLayer; i++){
        const _SXDecodedLayerData& layerData = data->allDataLayers[i];
        
        const std::vector<int>& lr  = layerData.layerRepresentation;
        desc->layers[i] = new _SXTilesLayerDescription;
        
        _SXTilesLayerDescription& currentLayer = *(desc->layers[i]);
        
        currentLayer.index          = i;
        currentLayer.sizeGrid       = layerData.layerSize;
        currentLayer.textureName    = std::string(layerData.layerTextureFile.c_str());
        currentLayer.TRID_list      = std::vector<TRId>(lr.size());
        
        for (size_t i = 0; i < lr.size(); ++i)
            currentLayer.TRID_list[i] = lr[i];
    };
}

void sxReleaseMapDescription(_SXMapDescription* mDes){
    for (const _SXTilesLayerDescription* tDesc : mDes->layers)
        delete tDesc;
}

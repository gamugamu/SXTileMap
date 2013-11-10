//
//  SXMapAtlasDescription.m
//  SXTileMap
//
//  Created by Abadie Loic on 19/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "SXMapAtlasDescription.h"
#import "SXMapAtlasDescription_private.h"
#import "SXDecoder_private.h"
#import "SXTypes_private.h"

@interface SXMapAtlasDescription(){
    _SXMapDescription _description;
}
@property(nonatomic, strong)NSMutableArray* layersTextureFileName;
@property(nonatomic, strong)NSString* fileName;
@end

@implementation SXMapAtlasDescription
@synthesize layersTextureFileName = _layersTextureFileName;

#pragma mark ============================ public ===============================
#pragma mark ===================================================================

+ (id)mapAtlasDescription:(NSString*)fileName{
    return [[SXMapAtlasDescription alloc] initWithDescription: fileName];
}

- (id)initWithDescription:(NSString*)description{
    if(self = [super init]){
        self.fileName = description;
        [self fakeADescription];
    }
    return self;
}

#pragma mark - public

- (size_t)layersCount{
    return _description.layersCount;
}

#pragma mark - alloc / dealloc

- (void)dealloc{
    [self releaseMapData];
}

#pragma mark ============================ private ==============================
#pragma mark ===================================================================

#pragma mark - hidden

- (const _SXTilesLayerDescription*)layerDescriptionForId:(uint)idLayer{
    if(idLayer < _description.layersCount)
        return _description.layers[idLayer];
    else
        return nil;
}

- (const _SXMapDescription*)dataDescription{
    return &_description;
}

#pragma mark - description

- (void)fakeADescription{
    char _test[] = "0005000500900090|010flower.png000400042_3_1_2_2_1_3_4_5_2_3_1_2_3_6_7_|007rgb.png000300031_9_1_9_1_3_7_3_7_\0";

    _SXDecodedMapData data = [SXDecoder decodeMapData: _test];
    [self allocAndinitMapData: data];
}

- (NSString*)description{
    return [NSString stringWithFormat: @"[SXMapDescription %p] size %u %u, tileSize %u %u",
            self, _description.sizeGrid.column, _description.sizeGrid.row,
            _description.sizeTile.width, _description.sizeTile.height];
}

#pragma mark - memoryManagement

- (void)allocAndinitMapData:(const _SXDecodedMapData&)data{
    logMapData(data);
    
    // Note: We are breaking here lot of constantness but since this is our ownership,
    // everthing is OK. What we don't want is third party changing what we are constructing here.
    size_t totalLayer   = data.allDataLayers.size();

    _description.layers         = std::vector<_SXTilesLayerDescription*>(totalLayer);
    _description.layersCount    = totalLayer;
    _description.sizeGrid       = data.gridSize;
    _description.sizeTile       = data.tileSize;
    
    for (int i = 0; i < totalLayer; i++){
        const _SXDecodedLayerData& layerData = data.allDataLayers[i];
        
        const std::vector<int>& lr  = layerData.layerRepresentation;
        _description.layers[i]      = new _SXTilesLayerDescription;
       
        _SXTilesLayerDescription& currentLayer = *(_description.layers[i]);
        
        currentLayer.layerId        = i;
        currentLayer.sizeGrid       = layerData.layerSize;
        currentLayer.textureName    = std::string(layerData.layerTextureFile.c_str());
        currentLayer.TRID_list      = std::vector<TRId>(lr.size());
        
        for (size_t i = 0; i < lr.size(); ++i)
            currentLayer.TRID_list[i] = lr[i];
    };
}

- (void)releaseMapData{
 /*  
    free ***
    should free every layer->textureName and Tlayyer->RID_list
    + mapLayer->layers
   */
#warning don't forget to freed
}
@end

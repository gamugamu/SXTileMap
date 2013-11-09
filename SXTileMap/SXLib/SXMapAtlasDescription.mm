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

#pragma mark - alloc / dealloc

- (void)dealloc{
    [self releaseMapData];
}

#pragma mark ============================ private ==============================
#pragma mark ===================================================================

#pragma mark - hidden

- (_SXTilesLayerDescription* const)layerDescriptionForId:(uint)idLayer{
    if(idLayer < _description.layersCount){
        return _description.layers + idLayer;
    }
    else
        return nil;
}

#pragma mark - description

- (void)fakeADescription{
    char _test[] = "0005000500900090|010flower.png000400042_3_1_2_2_1_3_4_5_2_3_1_2_3_6_7_|007rgb.png000300031_9_1_9_1_3_7_3_7_\0";

    struct decodedMapData data = [SXDecoder decodeMapData: _test];
    [self allocAndinitMapData: data];
}

- (NSString*)description{
    return [NSString stringWithFormat: @"[SXMapDescription %p] size %u %u, tileSize %u %u",
            self, _description.sizeGrid.column, _description.sizeGrid.row,
            _description.sizeTile.width, _description.sizeTile.height];
}

#pragma mark - memoryManagement

- (void)allocAndinitMapData:(const struct decodedMapData&)data{
    logMapData(data);
    
    size_t totalLayer   = data.allDataLayers.size();
    _description.layers = (_SXTilesLayerDescription*)malloc(sizeof(_SXTilesLayerDescription) * totalLayer);
    _description.layersCount    = totalLayer;
    _description.sizeGrid       = data.gridSize;
    _description.sizeTile       = data.tileSize;
    
    for (int i = 0; i < totalLayer; i++){
        const decodedLayerData& layerData = data.allDataLayers[i];
        
        const std::vector<int>& lr        = layerData.layerRepresentation;
        _SXTilesLayerDescription* des     = (_description.layers + i);
        
        // des->textureName is a const pointer to const and yeah I cheated.
        // But don't forget this is the SXMapAtlasDescription ownership, and should
        // be totally opaque to others. This is guaranteed that nobody can actually
        // get the pointer before it is initialized by SXMapDescription. And
        // moreover _SXTilesLayerDescription is private to client side.
        char** test     = (char**)&(des->textureName);
        *test           = (char*)malloc(sizeof(char) * layerData.layerTextureFile.size());

        if (*test != NULL)
            strcpy(*test, layerData.layerTextureFile.c_str());        

        des->TRID_list      = (TRId*)malloc(sizeof(uint) * lr.size());
        TRId* trid          = (TRId*)des->TRID_list; // uncast constantness
        des->layerId        = i;
        des->sizeGrid       = layerData.layerSize;
        
        for (size_t i = 0; i < lr.size(); ++i)
            trid[i] = lr[i];
    };
    
    _data = &_description;
}

- (void)releaseMapData{
 /*  
    free ***
    should free every layer->textureName and Tlayyer->RID_list
    + mapLayer->layers
   */
    free(_description.layers);
}
@end

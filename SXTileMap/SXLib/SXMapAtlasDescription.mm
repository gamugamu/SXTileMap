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
@property(nonatomic, strong)NSString* fileName;
@end

@implementation SXMapAtlasDescription

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
    char _test[] = "0005000500900090|011bonjour.png000200020_1_2_3_|013bonjouiur.png000300032_3_1_2_2_1_3_4_5_\0";

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
        
        des->TRID_list = (TRId*)malloc(sizeof(uint) * lr.size());
        TRId* trid     = (TRId*)des->TRID_list; // uncast constantness
        des->layerId   = i;
        des->sizeGrid  = layerData.layerSize;
        
        for (size_t i = 0; i < lr.size(); ++i)
            trid[i] = lr[i];
    };
    
    _data = &_description;
}

- (void)releaseMapData{
 /*  
    free ***
   */
    free(_description.layers);
}
@end

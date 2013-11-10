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
#import "SXDecoderToMapDescription.h"

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

#pragma mark - public

- (NSUInteger)layersCount{
    return _description.layersCount;
}

- (SXLayerDescription*)getLayerAtIndex:(NSUInteger)index{
    return nil;
}

#pragma mark - override

- (NSString*)description{
    return [NSString stringWithFormat: @"[SXMapAtlasDescription %p] fileName %@ - size %u %u - tileSize %u %u - numbers of layers %u",
            self, _fileName, _description.sizeGrid.column, _description.sizeGrid.row,
            _description.sizeTile.width, _description.sizeTile.height,
            [self layersCount]];
}

#pragma mark - alloc / dealloc

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

#pragma mark - memoryManagement

- (void)allocAndinitMapData:(const _SXDecodedMapData&)data{
    logMapData(data);
    sxInitAndConvertDecodedToMapDescription(&data, &_description);
}

- (void)releaseMapData{
    sxReleaseMapDescription(&_description);
}

@end

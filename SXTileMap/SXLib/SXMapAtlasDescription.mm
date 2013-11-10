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
#import "SXConverser.h"
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

- (NSString*)deepDescription{
    return [NSString stringWithFormat: @"%@", self];
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
        [self setUpDescription: description];
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

#pragma mark - setUp

- (void)setUpDescription:(NSString*)description{
    NSString* rawData = nil;
    [SXConverser decompressSXDataAtPath: description data: &rawData];
    _SXDecodedMapData data = [SXDecoder decodeMapData: rawData];
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

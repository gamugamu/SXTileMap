//
//  SXMapAtlas_hidden.h
//  SXTileMap
//
//  Created by Abadie, Loïc on 25/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "SXTilesLayer.h"
#import "SXTypes_private.h"

@class SXMapTile;
@class SXMapAtlas;

@interface SXTilesLayer(hidden)

- (id)initTilesLayerWithLayerDescription:(SXMapAtlasDescription*)description layerId:(uint)layerId;
- (void)changeMapTile:(SXMapTile*)mapTile withTextureId:(TRId)textureId;

@property(nonatomic, strong)SXMapAtlas* mapAtlas;

@end

//
//  SXMapAtlas_hidden.h
//  SXTileMap
//
//  Created by Abadie, Loïc on 25/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "SXTilesLayer.h"

@class SXMapTile;
@class SXMapAtlas;

@interface SXTilesLayer(hidden)

- (void)changeMapTile:(SXMapTile*)mapTile withTextureId:(TRId)textureId;

@property(nonatomic, strong)SXMapAtlas* mapAtlas;

@end

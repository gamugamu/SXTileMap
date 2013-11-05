//
//  SXMapAtlas_hidden.h
//  SXTileMap
//
//  Created by Abadie, Loïc on 25/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#ifndef SXTileMap_SXMapAtlas_hidden_h
#define SXTileMap_SXMapAtlas_hidden_h

#import "SXTilesLayer.h"

@class SXMapTile;

@interface SXTilesLayer(hidden)

- (void)changeMapTile:(SXMapTile*)mapTile withTextureId:(TRId)textureId;

@end

#endif
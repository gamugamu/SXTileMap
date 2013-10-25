//
//  SXMapAtlas_hidden.h
//  SXTileMap
//
//  Created by Abadie, Loïc on 25/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#ifndef SXTileMap_SXMapAtlas_hidden_h
#define SXTileMap_SXMapAtlas_hidden_h

#import "SXMapAtlas.h"

@class SXMapTile;

@interface SXMapAtlas(hidden)

- (void)changeMapTile:(SXMapTile*)mapTile withTextureId:(TRId)textureId;

@end

#endif

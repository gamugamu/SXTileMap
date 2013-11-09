//
//  SXMapAtlasDescription_private.h
//  SXTileMap
//
//  Created by loïc Abadie on 09/11/2013.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#ifndef SXTileMap_SXMapAtlasDescription_private_h
#define SXTileMap_SXMapAtlasDescription_private_h

#import "SXTypes_private.h"

@interface SXMapAtlasDescription()

- (_SXTilesLayerDescription* const)layerDescriptionForId:(uint)idLayer;
@property(nonatomic, readonly)_SXMapDescription* data;

@end

#endif

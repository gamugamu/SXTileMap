//
//  SXMapTile.h
//  SXTileMap
//
//  Created by Abadie Loic on 19/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import <SpriteKit/SKSpriteNode.h>
#include "SXTypes.h"

@class SXMapAtlas;
@class SXTilesLayer;

//----------------------------------------------------------------------------//
// SXMapTile define what is a tile.
//----------------------------------------------------------------------------//
@interface SXMapTile : NSObject

@property(nonatomic, assign)TRId textureId;

@property(nonatomic, strong, readonly)SKSpriteNode* sprite;

@property(nonatomic, strong, readonly)SXTilesLayer* layer;

@end

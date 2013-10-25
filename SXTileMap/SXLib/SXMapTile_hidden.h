//
//  SXMapTile_SXMapTile_hidden.h
//  SXTileMap
//
//  Created by Abadie Loic on 20/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "SXMapTile.h"
#import "SXTypes.h"

@class SXMapAtlas;

@interface SXMapTile()

@property(nonatomic, strong)SKSpriteNode* sprite;

/* Should only be used by SXTileBuilder */
@property(nonatomic, assign)_SXTileDescription tileDescription;
@property(nonatomic, strong)SXMapAtlas* mapAtlas;

@end

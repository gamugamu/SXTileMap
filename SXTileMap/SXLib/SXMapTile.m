//
//  SXMapTile.m
//  SXTileMap
//
//  Created by Abadie Loic on 19/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "SXMapTile.h"
#import "SXMapTile_private.h"
#import "SXTilesLayer_private.h"

@implementation SXMapTile
@synthesize  sprite             = _sprite,
             tileDescription    = _tileDescription,
             layer              = _layer,
             textureId          = _textureId;

#pragma mark ============================ public ===============================
#pragma mark ===================================================================

#pragma mark - getter / setter

- (void)setTextureId:(TRId)textureId{
    /* Note that a SXMapAtlas will own one mapBuilder per layer */
    [_layer changeMapTile: self withTextureId: textureId];
}

#pragma mark - alloc / dealloc

- (NSString*)description{
    return [NSString stringWithFormat: @"[SXMapTile %p]\tid: %u\t[x: %u y: %u]\ttrid: %u",
            self,
            _tileDescription.tileId,
            _tileDescription.position.x,
            _tileDescription.position.y,
            _tileDescription.textureRegionId];
}

@end

//
//  SXMapTile.m
//  SXTileMap
//
//  Created by Abadie Loic on 19/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "SXMapTile.h"
#import "SXMapTile_hidden.h"

@implementation SXMapTile
@synthesize  sprite             = _sprite,
             tileDescription    = _tileDescription;

#pragma mark ============================ public ===============================
#pragma mark ===================================================================

#pragma mark - alloc / dealloc

- (NSString*)description{
    return [NSString stringWithFormat: @"[SXMapTile %p]\tid: %lu\t[x: %u y: %u]\ttrid: %lu",
            self,
            _tileDescription.tileId,
            _tileDescription.position.x,
            _tileDescription.position.y,
            _tileDescription.textureRegionId];
}

@end

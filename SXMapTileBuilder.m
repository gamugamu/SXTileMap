//
//  SXMapTileBuilder.m
//  SXTileMap
//
//  Created by Abadie Loic on 19/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "SXMapTileBuilder.h"
#import "SXMapTile.h"

@implementation SXMapTileBuilder

#pragma mark ============================ public ===============================
#pragma mark ===================================================================

+ (NSArray*)tilesFromDescription:(SXMapAtlasDescription*)mapDescription{
    SXMapTile* test = [SXMapTile new];
    return @[test];
}

@end

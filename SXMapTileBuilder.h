//
//  SXMapTileBuilder.h
//  SXTileMap
//
//  Created by Abadie Loic on 19/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SXMapTile;
@class SXMapAtlasDescription;

//----------------------------------------------------------------------------//
// SXMapTileBuilder know how to build tile.
//----------------------------------------------------------------------------//
@interface SXMapTileBuilder : NSObject

+ (NSArray*)tilesFromDescription:(SXMapAtlasDescription*)mapDescription;

@end

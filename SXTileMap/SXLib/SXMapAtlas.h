//
//  SXMapAtlas.h
//  SXTileMap
//
//  Created by Abadie Loic on 19/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import <SpriteKit/SKSpriteNode.h>
#import "SXMapAtlasDescription.h" // for SXPoint
#import "SXTypes.h"

@class SXMapAtlasDescription;
@class SXTilesLayer;

//----------------------------------------------------------------------------//
// SXMapAtlas holds collection of tiles.
//----------------------------------------------------------------------------//
@interface SXMapAtlas : SKSpriteNode

/**
    Create a mapAtlas
 */
+ (SXMapAtlas*)mapAtlasWithDescription:(SXMapAtlasDescription*)data;

/**
    Create a mapAtlas
 */
- (id)initWithDescription:(SXMapAtlasDescription*)data;

/**
    Return all the layers holds by SXMapAtlas.
 */
@property(nonatomic, readonly)NSArray* /* SXTilesLayer */ allLayers;

/**
    Return the current coordinate space.
 */
@property(nonatomic, assign)SXCoordinateSpace currenSpaceCoordinate;
@end

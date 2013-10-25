//
//  SXMapTileBuilder.h
//  SXTileMap
//
//  Created by Abadie Loic on 19/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXMapAtlasDescription.h" // for SXPoint

@class SXMapTile;
@class SXMapAtlasDescription;

//----------------------------------------------------------------------------//
// SXMapTileBuilder know how to build tiles.
//----------------------------------------------------------------------------//
@interface SXMapTileBuilder : NSObject

- (SXMapTileBuilder*)initFromDescription:(SXMapAtlasDescription*)mapDescription;
- (NSArray*)generateTile;
- (NSUInteger)indexForPoint:(SXPoint)pnt;
@end

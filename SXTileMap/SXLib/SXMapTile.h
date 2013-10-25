//
//  SXMapTile.h
//  SXTileMap
//
//  Created by Abadie Loic on 19/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import <SpriteKit/SKSpriteNode.h>

//----------------------------------------------------------------------------//
// SXMapTile define what is a tile.
//----------------------------------------------------------------------------//
@interface SXMapTile : NSObject

@property(nonatomic, strong, readonly)SKSpriteNode* sprite;
@end

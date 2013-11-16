//
//  AppDelegate_SXLayerDescription_private.h
//  SXTileMap
//
//  Created by loïc Abadie on 10/11/2013.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "AppDelegate.h"
#import "SXTypes_private.h"

@class SXFileManager;

@interface SXLayerDescription ()

- (id)initWithLayerDescription:(const _SXTilesLayerDescription*)description
                andFileManager:(SXFileManager*)fileManager;
@end

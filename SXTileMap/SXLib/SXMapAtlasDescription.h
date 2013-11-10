//
//  SXMapAtlasDescription.h
//  SXTileMap
//
//  Created by Abadie Loic on 19/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import <Foundation/Foundation.h>

//----------------------------------------------------------------------------//
// SXMapAtlasDescription define what is a MapAtlas file.
//----------------------------------------------------------------------------//
@interface SXMapAtlasDescription : NSObject

+ (id)mapAtlasDescription:(NSString*)fileName;

- (size_t)layersCount;

@property(nonatomic, readonly)NSString* fileName;

@end

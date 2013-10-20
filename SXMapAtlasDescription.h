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
// opaque data
@property(nonatomic, assign /* readonly en prod */)void* data;
@end

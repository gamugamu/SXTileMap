//
//  SXMapAtlas.m
//  SXTileMap
//
//  Created by Abadie Loic on 19/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "SXMapAtlas.h"

@implementation SXMapAtlas

#pragma mark ============================ public ===============================
#pragma mark ===================================================================

+ (SXMapAtlas*)mapAtlasWithDescription:(void*)data{
    return [[SXMapAtlas alloc] initWithDescription: data];
}

- (id)initWithDescription:(void*)data{
    if(self = [super init]){
    
    }
    return self;
}

- (SXMapTile*)mapTileAtPoint:(void*)pnt{
    return nil;
}

- (NSArray*)mapTiles{
    return nil;
}

- (NSArray*)mapTilesFromRegion:(void*)region{
    return nil;
}

@end

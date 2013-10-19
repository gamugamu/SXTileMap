//
//  SXMapAtlas.m
//  SXTileMap
//
//  Created by Abadie Loic on 19/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "SXMapAtlas.h"
#import "SXMapTileBuilder.h"
#import "SXMapTile.h"

@interface SXMapAtlas()
@property(nonatomic, strong)NSArray* tiles;
@end

@implementation SXMapAtlas
@synthesize tiles = _tiles;

#pragma mark ============================ public ===============================
#pragma mark ===================================================================

+ (SXMapAtlas*)mapAtlasWithDescription:(SXMapAtlasDescription*)data{
    return [[SXMapAtlas alloc] initWithDescription: data];
}

- (id)initWithDescription:(SXMapAtlasDescription*)description{
    if(self = [super init]){
        [self setUpTiles: description];
        [self displayTiles: _tiles];
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

#pragma mark - override

- (CGRect)calculateAccumulatedFrame{
    // note: should take care
    return CGRectMake(0, 0, 10, 10);
}


#pragma mark ============================ private ==============================
#pragma mark ===================================================================

#pragma mark - setUp

- (void)setUpTiles:(SXMapAtlasDescription*)description{
    self.tiles = [SXMapTileBuilder tilesFromDescription: description];
}

#pragma mark - displayLogic

- (void)displayTiles:(NSArray*)tilesList{
    for(SXMapTile* tiles in tilesList)
        [self addChild: tiles.sprite];
}

@end

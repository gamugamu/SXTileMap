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
@property(nonatomic, strong)SXMapTileBuilder* mapBuilder;
@property(nonatomic, strong)NSArray* tiles;
@end

@implementation SXMapAtlas
@synthesize tiles       = _tiles,
            mapBuilder  = _mapBuilder;

#pragma mark ============================ public ===============================
#pragma mark ===================================================================

+ (SXMapAtlas*)mapAtlasWithDescription:(SXMapAtlasDescription*)data{
    return [[SXMapAtlas alloc] initWithDescription: data];
}

- (id)initWithDescription:(SXMapAtlasDescription*)description{
    if(self = [super init]){
        [self setUpMapBuilder: description];
        [self setUpTiles: description fromBuilder: _mapBuilder];
        [self displayTiles: _tiles];
    }
    return self;
}

- (SXMapTile*)tileAtPoint:(SXPoint)pnt{
    NSUInteger index = [_mapBuilder indexArrayForPoint: pnt];

    if(index < _tiles.count)
        return _tiles[index];
    else
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
    // note: should take care. Not implemented Yet.
    return CGRectMake(0, 0, 0, 0);
}


#pragma mark ============================ private ==============================
#pragma mark ===================================================================

#pragma mark - setUp

- (void)setUpMapBuilder:(SXMapAtlasDescription*)description{
    self.mapBuilder = [[SXMapTileBuilder alloc] initFromDescription: description];
}

- (void)setUpTiles:(SXMapAtlasDescription*)description
       fromBuilder:(SXMapTileBuilder*)builder{
    self.tiles = [builder generateTile];
}

#pragma mark - displayLogic

- (void)displayTiles:(NSArray*)tilesList{
    for(SXMapTile* tiles in tilesList)
        [self addChild: tiles.sprite];
}

@end

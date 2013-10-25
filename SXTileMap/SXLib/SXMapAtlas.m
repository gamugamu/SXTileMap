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
@end

@implementation SXMapAtlas
@synthesize mapBuilder  = _mapBuilder;

#pragma mark ============================ public ===============================
#pragma mark ===================================================================

+ (SXMapAtlas*)mapAtlasWithDescription:(SXMapAtlasDescription*)data{
    return [[SXMapAtlas alloc] initWithDescription: data];
}

- (id)initWithDescription:(SXMapAtlasDescription*)description{
    if(self = [super init]){
        [self setUpMapBuilder: description];
        [self setUpTiles: description fromBuilder: _mapBuilder];
        [self displayTiles: _mapBuilder.allGeneratedTiles];
    }
    return self;
}

- (SXMapTile*)tileAtPoint:(SXPoint)pnt{
    return [_mapBuilder tileAtPoint: pnt];
}

- (NSArray*)allTiles{
    return nil;
}

- (NSArray*)tilesFromRegion:(void*)region{
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
    [builder generateTile];
}

#pragma mark - displayLogic

- (void)displayTiles:(NSArray*)tilesList{
    for(SXMapTile* tiles in tilesList)
        [self addChild: tiles.sprite];
}

@end

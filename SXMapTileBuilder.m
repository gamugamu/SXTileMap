//
//  SXMapTileBuilder.m
//  SXTileMap
//
//  Created by Abadie Loic on 19/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SXMapTileBuilder.h"
#import "SXMapAtlasDescription.h"
#import "SXMapTile.h"
#import "SXMapTile_hidden.h"


inline SXRect getTextureRectForTileInMap(_SXTileDescription,
                                         _SXMapDescription* const);

@interface SXMapTileBuilder()
@property(nonatomic, strong)SXMapAtlasDescription* mapDescription;
@property(nonatomic, strong)NSArray* allGeneratedTiles;
@property(nonatomic, strong)SKTexture* texture;
@end

@implementation SXMapTileBuilder
@synthesize mapDescription      = _mapDescription,
            allGeneratedTiles   = _tiles;

#pragma mark ============================ public ===============================
#pragma mark ===================================================================

- (SXMapTileBuilder*)initFromDescription:(SXMapAtlasDescription*)mapDescription{
    if(self = [super init]){
        [self setUpMap: mapDescription];
    }
    return self;
}

- (void)generateTile{
    if(!_tiles)
        self.allGeneratedTiles = [self createTilesFromMapAtlasDesctiptor: _mapDescription];
}

- (SXMapTile*)tileAtPoint:(SXPoint)pnt{
    _SXMapDescription* des  = (_SXMapDescription*)_mapDescription.data;
    NSUInteger idx          =  pnt.x + pnt.y * des->sizeGrid.column;
    
    return (idx < _tiles.count)? _tiles[idx] : nil;
}

- (NSUInteger)indexForPoint:(SXPoint)pnt{
    _SXMapDescription* des = (_SXMapDescription*)_mapDescription.data;
    return pnt.x + pnt.y * des->sizeGrid.column;
}

#pragma mark ============================ private ==============================
#pragma mark ===================================================================

#pragma mark - setUp

- (void)setUpMap:(SXMapAtlasDescription*)mapDescription{
    self.mapDescription = mapDescription;
    self.texture = [SKTexture textureWithImageNamed: mapDescription.fileName];
}

#pragma mark - logic

- (NSArray*)createTilesFromMapAtlasDesctiptor:(SXMapAtlasDescription*)mapDescription{
    _SXMapDescription* des      = (_SXMapDescription*)mapDescription.data;
    NSMutableArray* nodeList    = [NSMutableArray new];
    _texture  = [SKTexture textureWithImageNamed: mapDescription.fileName];
    
    float g_w   = 1.f / des->sizeGrid.column;   // grid width
    float g_h   = 1.f / des->sizeGrid.row;      // grid height
    float t_w   = des->sizeTile.width;          // tile width
    float t_h   = des->sizeTile.width;          // tile height
    
    for (int i = 0; i < des->sizeGrid.row; ++i){
        for (int j = 0; j < des->sizeGrid.column; ++j){
            SXMapTile* tiles    = [SXMapTile new];
            CGRect area         = CGRectMake(i * g_w, j * g_h, g_w, g_h);
            //printf("[x:%u, y:%u] - id: %u (%u)\n", j, i, i * des->sizeGrid.column + j, des->sizeGrid.column);
            tiles.sprite = [self createNodeFromRect: area
                                            atPoint: (_SXGridSize){i, j}
                                               size: (CGSize){t_w, t_h}
                                            texture: _texture];
            
            UInt32 tid = i * des->sizeGrid.column + j;
            UInt32 rid = tid /* should be taken from mapAtlasDescription */;
            
            _SXTileDescription tDescription = {tid, rid, {j, i}};
            tiles.tileDescription = tDescription;

            [nodeList addObject: tiles];
        }
    }
    
    return nodeList;
}

SXRect getTextureRectForTileInMap(_SXTileDescription td,
                                  _SXMapDescription* const md){
    return (SXRect){ td.position.x * md->sizeTile.width,
                     td.position.y * md->sizeTile.height,
                     md->sizeTile.width,
                     md->sizeTile.height};
}

- (SKTexture*)texture:(SKTexture*)texture fromRect:(SXRect)rect{
    return [SKTexture textureWithRect: rect
                            inTexture: texture];
}

- (SKSpriteNode*)createNodeFromRect: (SXRect)rect
                            atPoint: (_SXGridSize)pnt
                               size: (CGSize)size
                            texture: (SKTexture*)texture{
    SKTexture* crop     = [self texture: texture fromRect: rect];
    SKSpriteNode* node  = [SKSpriteNode spriteNodeWithTexture: crop];
    CGPoint pos         = CGPointMake(node.size.width * pnt.row,
                                          node.size.height * pnt.column);
    node.position = pos;
    
    return node;
}
@end

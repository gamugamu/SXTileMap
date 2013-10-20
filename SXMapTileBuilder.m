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

@interface SXMapTileBuilder()
@property(nonatomic, strong)SXMapAtlasDescription* mapDescription;
@property(nonatomic, strong)SKTexture* texture;
@end

@implementation SXMapTileBuilder
@synthesize mapDescription = _mapDescription;

#pragma mark ============================ public ===============================
#pragma mark ===================================================================

- (SXMapTileBuilder*)initFromDescription:(SXMapAtlasDescription*)mapDescription{
    if(self = [super init]){
        [self setUpMap: mapDescription];
    }
    return self;
}

- (NSArray*)generateTile{
    return [self createTilesFromMapAtlasDesctiptor: _mapDescription];
}

- (NSUInteger)indexArrayForPoint:(SXPoint)pnt{
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
    NSLog(@"----> %u %u", des->sizeGrid.column, des->sizeGrid.row);
    
    for (int i = 0; i < des->sizeGrid.column; ++i){
        for (int j = 0; j < des->sizeGrid.row; ++j){
            SXMapTile* tiles    = [SXMapTile new];
            CGRect area         = CGRectMake(i * g_w, j * g_h, g_w, g_h);
                
            tiles.sprite = [self createNodeFromCrop: area
                                            atPoint: (_SXGridSize){i, j}
                                               size: (CGSize){t_w, t_h}];
            [nodeList addObject: tiles];
        }
    }
    
    return nodeList;
}

- (SKSpriteNode*)createNodeFromCrop:(CGRect)rect atPoint:(_SXGridSize)pnt size:(CGSize)size{
    SKTexture* crop         = [SKTexture textureWithRect: rect
                                               inTexture: _texture];
    SKSpriteNode* node      = [SKSpriteNode spriteNodeWithTexture: crop];
    CGPoint pos             = CGPointMake(node.size.width * pnt.row,
                                          node.size.height * pnt.column);
    node.position           = pos;
    
    return node;
}
@end

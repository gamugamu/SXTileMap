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

@interface SXMapTile()

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
    float size_W = 1.f / _texture.size.width / des->sizeGrid.column;
    float size_H = 1.f / _texture.size.height / des->sizeGrid.row;

    for (int i = 0; i < des->sizeGrid.row; ++i) {
        for (int j = 0; j < des->sizeGrid.column; ++j) {
            SXMapTile* tile = [SXMapTile new];
            
            CGRect area = (CGRect){ i * des->sizeTile.width,
                                    j * des->sizeTile.height,
                                    size_W,
                                    size_H};
            
            SKTexture* crop     = [SKTexture textureWithRect: area
                                                   inTexture: _texture];
            SKSpriteNode* node  = [SKSpriteNode spriteNodeWithTexture: crop
                                                                 size: (CGSize){60, 60}];
            node.position       = CGPointMake(i * 60, j * 60);
            tile.sprite         = node;
            
            [nodeList addObject: tile];
        }
    }
    return nodeList;
}

@end

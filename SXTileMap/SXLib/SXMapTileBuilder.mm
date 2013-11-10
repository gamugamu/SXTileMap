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
#import "SXMapAtlasDescription_private.h"
#import "SXMapTile.h"
#import "SXMapTile_private.h"

inline SXRect getTextureRectForTRIDInMap(TRId trid,
                                         _SXMapDescription* const);

@interface SXMapTileBuilder(){
    uint _layerId;
}
@property(nonatomic, strong)SXMapAtlasDescription* mapDescription;
@property(nonatomic, strong)NSArray* allGeneratedTiles;
@property(nonatomic, strong)SKTexture* texture;
@end

@implementation SXMapTileBuilder
@synthesize mapDescription      = _mapDescription,
            allGeneratedTiles   = _tiles;

#pragma mark ============================ public ===============================
#pragma mark ===================================================================

- (SXMapTileBuilder*)initFromDescription:(SXMapAtlasDescription*)mapDescription
                             withLayerId:(uint)layerId{
    if(self = [super init]){
        _layerId = layerId;
        self.mapDescription = mapDescription;
        [self setUpMap: [mapDescription layerDescriptionForId: layerId]];
    }
    return self;
}

- (void)generateTileFromCoordinateSpace:(SXCoordinateSpace)spaceCoordinate{
    if(!_tiles)
        self.allGeneratedTiles = [self createTilesFromMapAtlasDesctiptor: _mapDescription];
}

- (SXMapTile*)tileAtPoint:(SXPoint)pnt{
    _SXMapDescription* des  = (_SXMapDescription*)_mapDescription.data;
    NSUInteger idx          =  pnt.x + pnt.y * des->sizeGrid.column;
    
    return (idx < _tiles.count)? _tiles[idx] : nil;
}

- (void)changeMapTile:(SXMapTile*)mapTile withTextureId:(TRId)textureId{
    SXRect rect = getTextureRectForTRIDInMap(textureId,
                                            _mapDescription.data);
    
    _SXTileDescription tDes  = mapTile.tileDescription;
    tDes.textureRegionId     = textureId;
    mapTile.tileDescription  = tDes;
    
    mapTile.sprite.texture = [self texture: _texture fromRect: rect];
}

- (NSUInteger)indexForPoint:(SXPoint)pnt{
    _SXMapDescription* des = (_SXMapDescription*)_mapDescription.data;
    return pnt.x + pnt.y * des->sizeGrid.column;
}

#pragma mark ============================ private ==============================
#pragma mark ===================================================================

#pragma mark - setUp

#warning  we should can change the texture at runtime. Not what expected for the moment
- (void)setUpMap:(_SXTilesLayerDescription* const)layerDescription{
    NSString* fileName = [NSString stringWithUTF8String: layerDescription->textureName.c_str()];
    self.texture = [SKTexture textureWithImageNamed: fileName];
}

#pragma mark - logic

- (NSArray*)createTilesFromMapAtlasDesctiptor:(SXMapAtlasDescription*)mapDescription{
    _SXMapDescription* mDes          = (_SXMapDescription*)mapDescription.data;
    _SXTilesLayerDescription* tDes   = [mapDescription layerDescriptionForId: _layerId];

    NSMutableArray* nodeList = [NSMutableArray new];
    [self setUpMap: tDes];

    // Since textures in sprite are expressed in ratio,
    // we need then to compute the ratio for the tiles.
    CGSize ratioTM = (CGSize){
         (mDes->sizeTile.width * mDes->sizeGrid.row) / _texture.size.width,
         (mDes->sizeTile.height * mDes->sizeGrid.column) / _texture.size.height};
    
    // We create the row first, and go up throught the columns.
    for (int i = 0; i < tDes->sizeGrid.column; ++i){
        for (int j = 0; j < tDes->sizeGrid.row; ++j){
            
            SXMapTile* tiles    = [SXMapTile new];
            UInt32 tid          = i * mDes->sizeGrid.column + j;
            TRId rid            = tDes->TRID_list[i * tDes->sizeGrid.column + j];
            CGRect area         = getTextureRectForTRIDInMap(rid, mDes);

            tiles.sprite = [self createNodeFromRect: area
                                            atPoint: (_SXGridSize){ static_cast<uint_fast8_t>(j),
                                                                    static_cast<uint_fast8_t>(i)}
                                     tileSizeRatioX: ratioTM.width
                                     tileSizeRatioY: ratioTM.height
                                            texture: _texture];
          
            _SXTileDescription tDescription = {tid, rid, {  static_cast<uint_fast8_t>(j),
                                                            static_cast<uint_fast8_t>(i)}};
            tiles.tileDescription           = tDescription;
            
            [nodeList addObject: tiles];
        }
    }
    
    return nodeList;
}

SXRect getTextureRectForTRIDInMap(TRId trid,
                                  _SXMapDescription* const md){
    float g_w = 1.f / md->sizeGrid.column;   // grid width
    float g_h = 1.f / md->sizeGrid.row;      // grid height
    
    float currentRowSubOne = (trid % md->sizeGrid.row) * g_w;
    
    // should not outBound.
    trid %= md->sizeGrid.column * md->sizeGrid.row;

    // could crash if trid and md->sizeGrid.column are null.
    return {    currentRowSubOne,
                ((uint)(trid / md->sizeGrid.column) * g_h),
                g_w,
                g_h};;
}

- (SKTexture*)texture:(SKTexture*)texture fromRect:(SXRect)rect{
    return [SKTexture textureWithRect: rect
                            inTexture: texture];
}

- (SKSpriteNode*)createNodeFromRect: (SXRect)rect
                            atPoint: (_SXGridSize)pnt
                     tileSizeRatioX: (float)tileSizeRatioX
                     tileSizeRatioY: (float)tileSizeRatioY
                            texture: (SKTexture*)texture{
    SKTexture* crop     = [self texture: texture fromRect: rect];
    SKSpriteNode* node  = [SKSpriteNode spriteNodeWithTexture: crop];
    // we're assuming that a tile could be rectangle based shape != squared.
    node.xScale         = tileSizeRatioX;
    node.yScale         = tileSizeRatioY;
    CGPoint pos         = CGPointMake(node.size.width * pnt.row,
                                      node.size.height * pnt.column);
    node.position = pos;
    
    return node;
}
@end

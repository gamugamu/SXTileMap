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

const int SXBlankTileTRID   = -1;
const SXRect SXBlankRect    = CGRectZero;

inline SXRect getTextureRectForTRIDInMap(TRId trid,
                                         const _SXMapDescription*);

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
    const _SXMapDescription* des    = [_mapDescription dataDescription];
    NSUInteger idx                  =  pnt.x + pnt.y * des->sizeGrid.column;
    return (idx < _tiles.count)? _tiles[idx] : nil;
}

- (void)changeMapTile:(SXMapTile*)mapTile withTextureId:(TRId)textureId{
    SXRect rect = getTextureRectForTRIDInMap(textureId,
                                            [_mapDescription dataDescription]);
    
    _SXTileDescription tDes     = mapTile.tileDescription;
    tDes.textureRegionId        = textureId;

    mapTile.tileDescription     = tDes;
    mapTile.sprite.texture      = [self texture: _texture fromRect: rect];
}

- (NSUInteger)indexForPoint:(SXPoint)pnt{
    const _SXMapDescription* des = [_mapDescription dataDescription];
    return pnt.x + pnt.y * des->sizeGrid.column;
}

#pragma mark ============================ private ==============================
#pragma mark ===================================================================

#pragma mark - setUp

#warning  we should can change the texture at runtime. Not what expected for the moment
- (void)setUpMap:(const _SXTilesLayerDescription*)layerDescription{
    NSString* fileName  = [NSString stringWithUTF8String: layerDescription->textureName.c_str()];
    self.texture        = [SKTexture textureWithImageNamed: fileName];
}

#pragma mark - logic

- (NSArray*)createTilesFromMapAtlasDesctiptor:(SXMapAtlasDescription*)mapDescription{
    const _SXMapDescription* mDes           = [mapDescription dataDescription];
    const _SXTilesLayerDescription* tDes    = [mapDescription layerDescriptionForId: _layerId];

    NSMutableArray* nodeList = [NSMutableArray new];
    [self setUpMap: tDes];

    CGSize mapSize = (CGSize){
        static_cast<CGFloat>(mDes->sizeTile.width * mDes->sizeGrid.row),
        static_cast<CGFloat>(mDes->sizeTile.height * mDes->sizeGrid.column)};
    
    // Since textures in sprite are expressed in ratio,
    // we need then to compute the ratio for the tiles.
    CGSize ratioTM = (CGSize){
         mapSize.width / _texture.size.width,
         mapSize.height / _texture.size.height};
    
    // "0006000601000100|010flower.png000600062_3_1_2_2_1_3_4_5_2_3_12_22_12_12_12_|007rgb.png000300030_-1_1_2_3_3_7_3_7_\0";
    
    CGPoint offsetTiles = (CGPoint){
        static_cast<CGFloat>(mDes->sizeTile.width * mDes->sizeGrid.row / 2 - mDes->sizeTile.width / 2),
        static_cast<CGFloat>(mDes->sizeTile.height * mDes->sizeGrid.column / 2 - mDes->sizeTile.height / 2)};
    
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
                                           atOffset: offsetTiles
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
                                  const _SXMapDescription* md){
    if(trid == SXBlankTileTRID)
        return SXBlankRect;
    
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
                           atOffset: (CGPoint)offset
                            texture: (SKTexture*)texture{
    SKTexture* crop     = [self texture: texture fromRect: rect];
    SKSpriteNode* node  = [SKSpriteNode spriteNodeWithTexture: crop];
    // we're assuming that a tile could be rectangle based shape != squared.
    node.xScale         = tileSizeRatioX;
    node.yScale         = tileSizeRatioY;

    CGPoint pos         = CGPointMake(node.size.width * pnt.row - offset.x,
                                      node.size.height * pnt.column - offset.y);
    node.position = pos;
    
    return node;
}
@end

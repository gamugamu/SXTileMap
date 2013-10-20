//
//  SXMapTileBuilder.m
//  SXTileMap
//
//  Created by Abadie Loic on 19/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SXMapTileBuilder.h"
#import "SXMapTile.h"

@interface SXMapTileBuilder()
@property(nonatomic, strong)SKTexture* texture;
@end

@implementation SXMapTileBuilder

#pragma mark ============================ public ===============================
#pragma mark ===================================================================

- (SXMapTileBuilder*)initFromDescription:(SXMapAtlasDescription*)mapDescription{
    if(self = [super init]){
    
    }
    return self;
}

- (NSArray*)generateTile{
    SXMapTile* test = [SXMapTile new];
    return @[test];
}

#pragma mark ============================ private ==============================
#pragma mark ===================================================================

- (void)setUpTexture:(NSString*)fileName{
    self.texture = [SKTexture textureWithImageNamed: @"smile.png"];
}

@end

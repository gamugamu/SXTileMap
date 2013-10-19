//
//  SXMapTile.m
//  SXTileMap
//
//  Created by Abadie Loic on 19/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "SXMapTile.h"

@interface SXMapTile()
@property(nonatomic, strong)SKSpriteNode* sprite;
@end

@implementation SXMapTile
@synthesize  sprite = _sprite;

#pragma mark ============================ public ===============================
#pragma mark ===================================================================

#pragma mark - alloc / dealloc

- (id)init{
    if(self = [super init]){
        self.sprite = [SKSpriteNode spriteNodeWithColor: [UIColor redColor] size: (CGSize){100, 100}];
    }
    return self;
}

@end

//
//  SXMapAtlasDescription.m
//  SXTileMap
//
//  Created by Abadie Loic on 19/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "SXMapAtlasDescription.h"
#import "SXTypes_private.h"

@interface SXMapAtlasDescription(){
    _SXMapDescription _description;
}
@property(nonatomic, strong)NSString* fileName;
@end

@implementation SXMapAtlasDescription

#pragma mark ============================ public ===============================
#pragma mark ===================================================================

+ (id)mapAtlasDescription:(NSString*)fileName{
    return [[SXMapAtlasDescription alloc] initWithDescription: fileName];
}

- (id)initWithDescription:(NSString*)description{
    if(self = [super init]){
        self.fileName = description;
        [self fakeADescription];
    }
    return self;
}

#pragma mark - alloc / dealloc

- (void)dealloc{
    [self freedDataSpace];
}

#pragma mark ============================ private ==============================
#pragma mark ===================================================================

#pragma mark - description
#warning a enlever
- (void)fakeADescription{
    _description.sizeGrid = (_SXGridSize){5, 5};
    _description.sizeTile = (_SXTileSize){20, 20};
    _data = &_description;
}

- (NSString*)description{
    return [NSString stringWithFormat: @"[SXMapDescription %p] size %u %u, tileSize %u %u",
            self, _description.sizeGrid.column, _description.sizeGrid.row,
            _description.sizeTile.width, _description.sizeTile.height];
}

#pragma mark - memoryManagement

- (void)allocDataSpace{
   // _SXMapDescription.
}

- (void)freedDataSpace{

}
@end

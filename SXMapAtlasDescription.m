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
    [self allocDataSpace];
    
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
    _description.layers = malloc(sizeof(_SXTilesLayerDescription) * 2);
    int test[] = {1, 2 ,3, 0, 4, 3, 9, 0, 1203};
    
    for (int i = 0; i < 2; i++) {
        _SXTilesLayerDescription* des = (_description.layers + i);
        
        des->TRID_list = malloc(sizeof(50));
        printf("get %p %p\n", des, des->TRID_list);
        des->TRID_list[0] = (int)test[0];
        des->TRID_list[1] = test[1];
        des->TRID_list[2] = test[2];
    };
    
    printf("test %u %u\n", _description.layers[0].TRID_list[0], _description.layers[0].TRID_list[2]);
}

- (void)freedDataSpace{
 /*   for (int i = 0; i < 2; i++) {
        _SXTilesLayerDescription* des = *(_description.layers + i);
        free((void*)des->TRID_list);
    };
   */
    free(_description.layers);
}
@end

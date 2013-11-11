//
//  SXLayerDescription.m
//  SXTileMap
//
//  Created by loïc Abadie on 10/11/2013.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "SXLayerDescription.h"
#import "SXLayerDescription_private.h"

@interface SXLayerDescription(){
    _SXTilesLayerDescription _description;
}
@end

@implementation SXLayerDescription

#pragma mark -------------------------- public ---------------------------------
#pragma mark -------------------------------------------------------------------

#pragma mark - public

- (NSUInteger)getIndex{
    return _description.index;
}

#pragma mark - override

- (NSString*)description{
    return [NSString stringWithFormat: @"[SXLayerDescription %p] %s - index %u - size %u %u %@",
            self, _description.textureName.c_str(), _description.index,
            _description.sizeGrid.row, _description.sizeGrid.column,
            [self matrixDescription: _description]];
}

- (NSString*)matrixDescription:(const _SXTilesLayerDescription&)description{
    NSMutableString* matrixData = [NSMutableString string];
    
    // Note that the safest way would be to take the TRID_list lenght. We
    // are assuming that there are as much data as there are row * column data.
    for (int i = description.sizeGrid.row - 1;  i >= 0; --i) {
        [matrixData appendString: [NSString stringWithFormat: @"\r      "]];
        for (int j = 0;  j < description.sizeGrid.column; j++) {
            int trid = description.TRID_list[i * description.sizeGrid.column + j];
            [matrixData appendString: trid != SXBlankTileTRID?
             [NSString stringWithFormat: @"%03u ", trid] : @"--- "];
        }
    }
    return matrixData;
}

#pragma mark -------------------------- private --------------------------------
#pragma mark -------------------------------------------------------------------

#pragma mark - hidden

- (id)initWithLayerDescription:(const _SXTilesLayerDescription*)description{
    if(self = [super init]) {
        _description = *description;
    }
    return self;
}

@end

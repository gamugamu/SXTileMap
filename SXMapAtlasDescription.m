//
//  SXMapAtlasDescription.m
//  SXTileMap
//
//  Created by Abadie Loic on 19/10/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "SXMapAtlasDescription.h"

@interface SXMapAtlasDescription()
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

#pragma mark ============================ private ==============================
#pragma mark ===================================================================

_SXMapDescription description;

- (void)fakeADescription{
    description.sizeGrid = (_SXGridSize){5, 5};
    description.sizeTile = (_SXTileSize){20, 20};
    _data = &description;
}

@end

//
//  SX2DMatrice_hidden.h
//  SXTileMap
//
//  Created by Abadie, Loïc on 05/11/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "SX2DMatrice.h"
#import <vector>

@interface SX2DMatrice(hidden)

- (std::vector< std::vector<unsigned> >)getRawMatrixCopy;

@end
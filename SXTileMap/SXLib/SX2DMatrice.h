//
//  SXMatrice.h
//  SXTileMap
//
//  Created by Abadie, Loïc on 05/11/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXTypes.h"

//----------------------------------------------------------------------------//
// SXMatrice représent a 2D matrix.
//----------------------------------------------------------------------------//
@interface SX2DMatrice : NSObject

- (id)initWith2DMatrix:(NSArray*)array onError:(NSError**)cb_error;

- (void)addRow:(NSArray*)array;

- (void)addCollumn:(NSArray*)array;

- (matrixSize)size;
@end

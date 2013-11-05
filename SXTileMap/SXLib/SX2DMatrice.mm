//
//  SXMatrice.m
//  SXTileMap
//
//  Created by Abadie, Loïc on 05/11/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "SX2DMatrice.h"
#import <vector>

@interface SX2DMatrice(){
    std::vector< std::vector<unsigned>> matrix;
}
@end

@implementation SX2DMatrice

#pragma mark -------------------------- public ---------------------------------
#pragma mark -------------------------------------------------------------------

- (id)initWith2DMatrix:(NSArray*)array onError:(NSError**)cb_error{
    if(self = [super init]){
        *cb_error = [self check2DMatrixValidity: array];
        
        if(!*cb_error)
            [self setUp2DMatrix: array];
    }
    return self;
}

- (void)addRow:(NSArray*)array{

}

- (void)addCollumn:(NSArray*)array{

}

#pragma mark - getter  / setter

- (matrixSize)size{
    return (matrixSize){0, 0};
}

#pragma mark -------------------------- private --------------------------------
#pragma mark -------------------------------------------------------------------

#pragma mark - logic

- (NSError*)check2DMatrixValidity:(NSArray*)array{
    NSError* error = nil;
    Class nsArrayClass  = [NSArray class];
    Class nsNumberClass = [NSNumber class];

    // Note that checking a 2D matrix is epensively huge and unessecary
    // due to obj-c lack of static checking. This will not happen if we direclty
    // deal with C++ colletion. But SX2DMatrix is a front-end user, and we can't
    // let it deals with direct C++ / C injection.
    for (id object in array){
        if([object isKindOfClass: nsArrayClass]){
            for (id subObject in array)
                if(![subObject isKindOfClass: nsNumberClass])
                    goto badMatrix;
        }else{
            badMatrix:
            error = [NSError errorWithDomain: @"Bad2DMatrix"
                                        code: 10
                                    userInfo: nil];
            break;
        }
    }
    return error;
}

#pragma mark - setup

- (void)setUp2DMatrix:(NSArray*)array{

}

@end

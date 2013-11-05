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

- (id)initWith2DMatrix:(NSArray*)array onError:(NSError* __autoreleasing*)cb_error{
    if(self = [super init]){
        [self buildMatrix: array onError: cb_error];
    }
    return self;
}

- (void)addRow:(NSArray*)array{
    // todo
}

- (void)addCollumn:(NSArray*)array{
    // todo
}

#pragma mark - getter  / setter

- (matrixSize)size{
    return (matrixSize){0, 0};
}

#pragma mark -------------------------- private --------------------------------
#pragma mark -------------------------------------------------------------------

#pragma mark - logic

- (NSError*)check2DMatrixValidity:(NSArray*)array matrixSize:(matrixSize*)size{
    NSError* error = nil;
    Class nsArrayClass  = [NSArray class];
    Class nsNumberClass = [NSNumber class];
    int vectorSize      = -1;
    
    // Note that checking a 2D matrix is epensively huge and unessecary
    // due to obj-c lack of static checking. This will not happen if we direclty
    // deal with C++ colletion. But SX2DMatrix is a front-end user, and we can't
    // let it deals with direct C++ / C injection.
    for (id object in array){
        if([object isKindOfClass: nsArrayClass]){
            NSUInteger count = [object count];
            
            // if the row are not the same size, the greatest will be for
            // all rows.
            if(vectorSize < count)
                vectorSize = count;
                
            for (id subObject in object)
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

- (void)buildMatrix:(NSArray*)array onError:(NSError**)cb_error{
    matrixSize size;
    
    if(cb_error)
        *cb_error = [self check2DMatrixValidity: array matrixSize: &size];
    
    if(cb_error && !*cb_error)
        [self setUp2DMatrix: array matrixSize: size];
}

#pragma mark - setup

// call this method only if you know the 2DMatrix is valid
- (void)setUp2DMatrix:(NSArray*)array matrixSize:(matrixSize)mSize{
    for (int i = 0; i < array.count; i++) {
        std::vector<unsigned> l{mSize.row, 0};
        NSArray* rows = array[i];
        
        for (int j = 0; j < rows.count; j++)
            l[j] = [rows[j] unsignedIntegerValue];
        
        matrix.push_back(l);
    }
    printf("gfdf\n");
}

@end

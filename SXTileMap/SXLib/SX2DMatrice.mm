//
//  SXMatrice.m
//  SXTileMap
//
//  Created by Abadie, Loïc on 05/11/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "SX2DMatrice.h"
#import "SX2DMatrice_hidden.h"
#import <vector>
#import <string>

@interface SX2DMatrice(){
    std::vector< std::vector<unsigned>> _matrix;
}

@property(nonatomic, assign)SXMatrixSize size;
@end

@implementation SX2DMatrice
@synthesize size = _size;

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

- (SXMatrixSize)size{
    return _size;
}

#pragma mark - override

- (NSString*)description{
    std::string d;
    
    for(int i = 0; i < _size.column; ++i){
        for (int j = 0; j < _size.row; ++j)
            d += "[" + std::to_string(_matrix[i][j]) + "]";

        d += "\n";
    }

    return [NSString stringWithFormat: @"\n[SX2DMatrice %p]\n%s", self, d.c_str()];
}

#pragma mark -------------------------- private --------------------------------
#pragma mark -------------------------------------------------------------------

#pragma mark - hidden

- (std::vector< std::vector<unsigned> >)getRawMatrixCopy{
    return _matrix;
}

#pragma mark - logic

- (NSError*)check2DMatrixValidity:(NSArray*)array matrixSize:(SXMatrixSize*)size{
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
            int count = [object count];
            
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

    if(!error)
        _size = {static_cast<uint_fast8_t>(vectorSize),
                 static_cast<uint_fast8_t>(array.count)};
    
    return error;
}

- (void)buildMatrix:(NSArray*)array onError:(NSError**)cb_error{
    if(cb_error)
        *cb_error = [self check2DMatrixValidity: array matrixSize: &_size];

    if(cb_error && !*cb_error)
        [self setUp2DMatrix: array matrixSize: _size];
}

#pragma mark - setup

// call this method only if you know the 2DMatrix is valid
- (void)setUp2DMatrix:(NSArray*)array matrixSize:(SXMatrixSize)mSize{
    for (int i = 0; i < array.count; i++) {
        std::vector<unsigned> l(mSize.row, 0);
#warning sometime pointer are invalide (what are u doing ARC)?
        NSArray* rows = array[i];

        for (int j = 0; j < rows.count; j++)
            l[j] = [rows[j] unsignedIntegerValue];

        _matrix.push_back(l);
    }
}

@end

//
//  SXDecoder.m
//  SXTileMap
//
//  Created by Abadie, Loïc on 05/11/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "SXDecoder.h"
#import "SXTypes_private.h"

#define GRID_PER_RANGE 4
#define LAYER_SEPARATOR @"|"
#define MAX_LENGHT_TEXT_FORMAT 3
// wich mean if a text as more than 100 caracter, we' ll get an undefined behaviour

@implementation SXDecoder

#pragma mark -------------------------- public ---------------------------------
#pragma mark -------------------------------------------------------------------

+ (void)testRepresentation{
    /*
        sizeGrid_sizeTile_NBcharFileName_fileName_layerSize_layerRep
     */
    char _test[] = "0015001500300030|011bonjour.png000200020_1_0_1\0";
    [self analyseRepresentation: _test];
}

#pragma mark -------------------------- private --------------------------------
#pragma mark -------------------------------------------------------------------

+ (void)analyseRepresentation:(char*)data{
    NSString* rawRepresentation = [NSString stringWithCString: data
                                                     encoding: NSUTF8StringEncoding];

    @try {
        _SXGridSize gridSize;
        _SXTileSize tileSize;

        NSRange range   = (NSRange){0, GRID_PER_RANGE};
        
        // take the gridSize
        gridSize.row    = [[rawRepresentation substringWithRange: range] integerValue];
        range.location += GRID_PER_RANGE;
        gridSize.column = [[rawRepresentation substringWithRange: range] integerValue];
        
        // take the tilesSize
        range.location += GRID_PER_RANGE;
        tileSize.width  = [[rawRepresentation substringWithRange: range] integerValue];
        range.location += GRID_PER_RANGE;
        tileSize.height = [[rawRepresentation substringWithRange: range] integerValue];

        NSMutableArray* layers = [[rawRepresentation componentsSeparatedByString: LAYER_SEPARATOR] mutableCopy];
        
        NSLog(@"gridSize %u %u", gridSize.row, gridSize.column);
        NSLog(@"tileSize %u %u", tileSize.width, tileSize.height);
        // first one is not a layer.
        [layers removeObjectAtIndex: 0];
        
        for(NSString* layer in layers){
            NSRange range = (NSRange){0, MAX_LENGHT_TEXT_FORMAT};
            NSUInteger textLenght = [[layer substringWithRange: range] integerValue];
           
            range = (NSRange){MAX_LENGHT_TEXT_FORMAT, textLenght};

            NSLog(@"layer filename ---> %@", [layer substringWithRange: range]);
            // take the layerSize
            range.location += textLenght;
            range.length    = GRID_PER_RANGE;
            
            _SXGridSize layerSize;

            layerSize.row     = [[layer substringWithRange: range] integerValue];
            range.location   += GRID_PER_RANGE;
            layerSize.column  = [[layer substringWithRange: range] integerValue];

            NSLog(@"layerSize %u %u", layerSize.row, layerSize.column);

        }
    }
    @catch (NSException *exception) {
        
    }
}

@end

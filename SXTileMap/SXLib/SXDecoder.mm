//
//  SXDecoder.m
//  SXTileMap
//
//  Created by Abadie, Loïc on 05/11/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "SXDecoder.h"
#import "SXDecoder_private.h"
#import "SXTypes_private.h"

#define GRID_PER_RANGE 4                    // 4*4 max values digit for the grid and tile.
#define LAYER_SEPARATOR @"|"                // A tag who define the separation for all layers.
#define MAX_LENGHT_TEXT_FORMAT 3            // File name should have less than 100 caracteres.
#define MAX_CHAR_SCANNER_BUFFER_LENGHT 5    // A buffer lenght who hold a fixed number. Used to hold the
                                            // string representation of each individual value of the layers.
                                            // 5 chars is really enought.

// wich mean if a text as more than 100 caracter, we' ll get an undefined behaviour

@implementation SXDecoder

#pragma mark -------------------------- public ---------------------------------
#pragma mark -------------------------------------------------------------------

+ (struct decodedMapData)decodeMapData:(char*)data{
    /*
        sizeGrid_sizeTile_NBcharFileName_( | n time)_fileName_layerSize_layerRep
     */
    return [self makeDataDecoding: data];
}

#pragma mark -------------------------- private --------------------------------
#pragma mark -------------------------------------------------------------------

#pragma mark - logic
    
+ (struct decodedMapData)makeDataDecoding:(char*)data{
    NSString* rawRepresentation = [NSString stringWithCString: data
                                                     encoding: NSUTF8StringEncoding];
    @try {
        _SXGridSize gridSize;
        _SXTileSize tileSize;

        struct decodedMapData mapData;
        
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
        
        mapData.gridSize = gridSize;
        mapData.tileSize = tileSize;
        
        // first one is not a layer data.
        [layers removeObjectAtIndex: 0];
        
        // for the rest
        for(int i = 0; i < layers.count; i++){
            NSString* layer = layers[i];
            struct decodedLayerData layerData;
            
            NSRange range           = (NSRange){0, MAX_LENGHT_TEXT_FORMAT};
            NSUInteger textLenght   = [[layer substringWithRange: range] integerValue];
           
            range = (NSRange){MAX_LENGHT_TEXT_FORMAT, textLenght};
            
            const char* textureFile     = [[layer substringWithRange: range]
                                           cStringUsingEncoding: NSUTF8StringEncoding];
            layerData.level             = i;
            layerData.layerTextureFile  = std::string(textureFile);

            // take the layerSize
            range.location += textLenght;
            range.length    = GRID_PER_RANGE;
            
            layerData.layerSize.row     = [[layer substringWithRange: range] integerValue];
            range.location              += GRID_PER_RANGE;
            layerData.layerSize.column  = [[layer substringWithRange: range] integerValue];
            range.location              += GRID_PER_RANGE;

            // and now take the layerRepresentation
            range.length                    = layer.length - range.location;
            NSString* layerRepresentation   = [layer substringWithRange: range];
            
            char* allValues = (char*)[layerRepresentation cStringUsingEncoding: NSUTF8StringEncoding];
            char scanner[MAX_CHAR_SCANNER_BUFFER_LENGHT] = {'\0'};
            
            int j = 0;
            while (*allValues != '\0'){
                if(*allValues == '_'){
                    layerData.layerRepresentation.push_back(atoi(&scanner[0]));
                    j = 0;
                    scanner[0] = '\0';
                }else{
                    scanner[j++] = allValues[0];
                }
                allValues++;
            }

            mapData.allDataLayers.push_back(layerData);
        }
        
        return mapData;
    }
    @catch (NSException *exception) {
        
    }
}

@end
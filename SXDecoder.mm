//
//  SXDecoder.m
//  SXTileMap
//
//  Created by Abadie, Loïc on 05/11/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "SXDecoder.h"
#import "SXTypes_private.h"
#import "SXTypes_encodage.hh"

#define GRID_PER_RANGE 4
#define LAYER_SEPARATOR @"|"
#define MAX_LENGHT_TEXT_FORMAT 3
// wich mean if a text as more than 100 caracter, we' ll get an undefined behaviour

@implementation SXDecoder

#pragma mark -------------------------- public ---------------------------------
#pragma mark -------------------------------------------------------------------

+ (void)testRepresentation{
    /*
        sizeGrid_sizeTile_NBcharFileName_( | n time)_fileName_layerSize_layerRep
     */
    char _test[] = "0015001500300030|011bonjour.png000200020_1_2_3_|013bonjouiur.png000300032_3_1_2_2_1_3_4_5_\0";
    struct decodedMapData data = [self analyseRepresentation: _test];
    logMapData(data);
}

#pragma mark -------------------------- private --------------------------------
#pragma mark -------------------------------------------------------------------

+ (struct decodedMapData)analyseRepresentation:(char*)data{
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
            // we strongly assuming that there will be less than 100000 differents
            // values.
            char scanner[5] = {'\0'};
            
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

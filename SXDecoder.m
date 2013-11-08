//
//  SXDecoder.m
//  SXTileMap
//
//  Created by Abadie, Loïc on 05/11/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "SXDecoder.h"
#import "SXTypes.h"

@implementation SXDecoder

#pragma mark -------------------------- public ---------------------------------
#pragma mark -------------------------------------------------------------------

+ (void)testRepresentation{
    /*
        sizeGrid_sizeTile_numberLayer_NBcharFileName_fileName_layerSize
     */
    char _test[] = "00150015_00300030_04_11_bonjour.png_00020002_01010\0";
    [self analyseRepresentation: _test];
}

#pragma mark -------------------------- private --------------------------------
#pragma mark -------------------------------------------------------------------

+ (void)analyseRepresentation:(char*)data{
    NSString* rawRepresentation = [NSString stringWithCString: data
                                                     encoding: NSUTF8StringEncoding];

    @try {
        NSRange range = (NSRange){0, 4};
        
        NSLog(@"gridSize %u %u",
              [[rawRepresentation substringWithRange: range] integerValue],
              [[rawRepresentation substringWithRange: range] integerValue]);
    }
    @catch (NSException *exception) {
        
    }
    printf("aaa %s\n", data);
}
@end

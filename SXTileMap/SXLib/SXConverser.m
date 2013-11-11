//
//  SXConverser.m
//  SXTileMap
//
//  Created by Abadie, Loïc on 08/11/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "SXConverser.h"
#import "lzfx.h"

@implementation SXConverser

+ (BOOL)archivefile:(NSString*)file atPath:(NSString*)dcumentPath{
    unsigned lenght = 200;
#warning TODO and unsafe

    char test[]     = "0015001500300030|011bonjour.png000200020_1_2_3|013bonjouiur.png000300032_3_1_2_2_1_3_4_5\0\n";
    char* output    = (char*)calloc(lenght, sizeof(char));
    
    if(output == NULL)
        printf("failed\n");
        
    int success = lzfx_compress(&test, sizeof(test) / sizeof(*test),
                                output, &lenght);
    
    printf("[%i] compress result %s %u\n", success, output, lenght);
    
    success = lzfx_decompress(output, lenght,
                              &test,  &lenght);
    
    printf("\n");
    // insert code here...
    
    printf("[%i] decompress result_2 ---> %s %u\n", success, test, lenght);
    return NO;
}

+ (BOOL)decompressSXDataAtPath:(NSString*)dcumentPath data:(NSString**)data{
#warning TODO and unsafe
    unsigned lenght = 200;

    char test[]     = "0009000901000100|010flower.png00040004_3_1_2_2_1_3_4_5_2_3_12_22_12_12_12_|007rgb.png000300030_-1_1_2_3_3_7_3_7_\0";
    char* output    = (char*)calloc(lenght, sizeof(char));
    
    if(output == NULL)
        printf("failed\n");

    int success = lzfx_compress(&test, sizeof(test) / sizeof(*test),
                                output, &lenght);
    success = lzfx_decompress(output, lenght,
                              &test,  &lenght);
    if(success < 0){
        return NO;
    }
    else{
        *data = [NSString stringWithUTF8String: test];
        return (*data).length;
    }
}

@end

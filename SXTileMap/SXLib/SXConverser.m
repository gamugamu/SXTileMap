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
    
    char test[]     = "0015001500300030|011bonjour.png000200020_1_2_3|013bonjouiur.png000300032_3_1_2_2_1_3_4_5\0\n";
    char* output    = (char*)calloc(lenght, sizeof(char));
    
    if(output == NULL)
        printf("failed\n");
        
    int success = lzfx_compress(&test, sizeof(test) / sizeof(*test),
                                output, &lenght);
    
    printf("[%i] compress result %s %u\n", success, output, lenght);
    
    success = lzfx_decompress(output, lenght,
                              &test,  &lenght);
    
    // insert code here...
    
    printf("[%i] decompress result_2 ---> %s %u\n", success, test, lenght);
    return NO;
}

+ (BOOL)unarchivefile:(NSString*)dcumentPath{
    return NO;
}

@end

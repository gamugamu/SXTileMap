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
    
    char test[]     = "a_a_a_a_a_a_a_a_a\n";
    char* output    = (char*)calloc(lenght, sizeof(char));
    
    if(output == NULL)
        printf("failed\n");
    
    printf("%zu size of %zu\n", sizeof(output) / sizeof(*output), sizeof(test) / sizeof(*test));
    
    int success = lzfx_compress(&test, sizeof(test) / sizeof(*test),
                                output, &lenght);
    
    printf("[%i] result %s %s %u\n", success, test, output, lenght);
    
    success = lzfx_decompress(output, lenght,
                              &test,  &lenght);
    
    // insert code here...
    
    printf("[%i] result_2 ---> %s %s %u\n", success, output, test, lenght);
    return NO;
}

+ (BOOL)unarchivefile:(NSString*)dcumentPath{
    return NO;
}

@end

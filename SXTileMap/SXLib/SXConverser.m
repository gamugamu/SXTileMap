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
    unsigned lll = 0;
    int success = -1;
    
    char test[]     = "0009000901000100|010flower.png00040004_3_1_2_2_1_3_4_5_2_3_12_22_12_12_12_|007rgb.png000300030_-1_1_2_3_3_7_3_7_\0";
    unsigned lenght = sizeof(test) / sizeof(*test) + 5;
    char* test_2    = malloc(lenght);
    char output[200];
    
    // char path[] = "/Users/loicabadie/Documents/temp/SXTileMap/SXTileMap/test.txt";
    
    success = lzfx_compress(test, sizeof(test) / sizeof(*test) + 1,
                            &output, &lenght);
    
    printf("\n\n\nDid success %i - %u\n\n\n", success, lenght);

    for (int i = 0; i < lenght; i++) {
        printf("%c", (output[i]));
    }
    
    // writeToFile(path, output, lenght);
    
    /*   char* aaa = readFile(path, &lenght, NULL);
     printf("\n\n****** lenght %u\n", lenght);
     
     for (int i = 0; i < lenght; i++) {
     printf("%c", (aaa[i]));
     }
     
     printf("\n\n******\n");
     */
    lenght = 114 + 1;
    success = lzfx_decompress(output, 101,
                              test_2,  &lenght);
    printf("\n\n\n 2 Did success %i - %u \n\n\n", success, lenght);

    for (int i = 0; i < lenght; i++) {
        printf("%c", (test_2[i]));
    }
    printf("\n\n** %u *\n\n", lenght);
    printf("final %u - %zu", lenght, sizeof(test) / sizeof(*test));
    
    if(success < 0){
        return NO;
    }
    else{
        *data = [NSString stringWithUTF8String: test_2];
        return (*data).length;
    }
}

void writeToFile(char *filename, const char* input, unsigned lenght){
    FILE *fp = fopen(filename, "wb");
    
    if(fp == NULL)
        return;
    
    fwrite(input, sizeof(input[0]), lenght, fp);
    fclose(fp);
}

char* readFile(const char *filename, unsigned* lenght, unsigned* errorCode){
    char *buffer    = NULL;
    int read_size;
    
    FILE *handler   = fopen(filename, "r");
    
    if(handler){
        fseek(handler, 0, SEEK_END);
        
        *lenght = ftell(handler);
        rewind(handler);
        
        buffer      = (char*)malloc(sizeof(char) * (*lenght + 1) );
        read_size   = fread(buffer,sizeof(char), *lenght, handler);
        //   buffer[*lenght + 1] = '\0';
        
        if(*lenght != read_size){
            free(buffer);
            buffer = NULL;
            
            if(errorCode)
                *errorCode = 100;
            
            goto readFileFailed;
        }
    }else{
        if(errorCode)
            *errorCode = 100; // file not found
    readFileFailed:
        *lenght = 0;
        printf("error\n");
    }
    
    return buffer;
}

@end

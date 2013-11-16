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
    char output[200];
    
    if(output == NULL)
        printf("failed\n");

    int success = lzfx_compress(test, sizeof(test) / sizeof(*test),
                                output, &lenght);
    
    for (int i = 0; i < lenght; i++) {
        printf("%c", (output[i]));
    }
    
    char path[] = "/Users/loicabadie/Documents/temp/SXTileMap/SXTileMap/test.txt";
    
    writeToFile(path, output, lenght);
    
    char* aaa = readFile(path);
    printf("\n\n****** lenght %u\n", lenght);
    
    for (int i = 0; i < lenght; i++) {
        printf("%c", (aaa[i]));
    }
    
    printf("\n\n******\n");

    success = lzfx_decompress(aaa, lenght,
                              test,  &lenght);
    
    
    printf("%s", test);

    if(success < 0){
        return NO;
    }
    else{
        *data = [NSString stringWithUTF8String: test];
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

char* readFile(char *filename){
    char *buffer = NULL;
    int string_size,read_size;
    FILE *handler = fopen(filename,"r");
    
    if (handler){
        //seek the last byte of the file
        fseek(handler, 0, SEEK_END);
        
        //offset from the first to the last byte, or in other words, filesize
        string_size = ftell(handler);
        
        printf("\nsize %i \n", string_size);
        //go back to the start of the file
        rewind(handler);

        //allocate a string that can hold it all
        buffer = (char*) malloc (sizeof(char) * (string_size + 1) );
        
        //read it all in one operation
        read_size = fread(buffer,sizeof(char), string_size, handler);
        
        //fread doesnt set it so put a \0 in the last position
        //and buffer is now officialy a string
        
        if (string_size != read_size) {
            //something went wrong, throw away the memory and set
            //the buffer to NULL
            free(buffer);
            buffer = NULL;
        }
    }
    
    return buffer;
}

@end

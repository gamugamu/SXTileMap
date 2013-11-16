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

+ (BOOL)decompressSXDataAtPath:(NSString*)dcumentPath data:(NSString* __strong*)data{
    unsigned compressedLenght   = 0;
    unsigned outputBufferLenght = 0;
    char* outputBuffer          = NULL;
    bool didSucceed             = false;
    
    char path[] = "/Users/loicabadie/Documents/temp/SXTileMap/SXTileMap/test.txt";
    
    char* compressedData = readFile(path, &compressedLenght, NULL);

    // first we need to konw the buffer size. According to the doc, it's very
    // fast. It say also to send an output buffer null to get the actual size,
    // wich is actually false. We need to send a valid pointer.
    int success = lzfx_decompress(compressedData, compressedLenght,
                    &outputBuffer,  // we're faking a pointer an order to get the length.
                                    // It's not actually used into the implementation. If
                                    // we don't, we'll get an error parameter return value.
                                    // Even if it is what was specified into the documentation (i believe).
                    &outputBufferLenght);
    
    if(success > -1){
        outputBuffer = malloc(sizeof(char) * outputBufferLenght);
    
        success = lzfx_decompress(compressedData, compressedLenght,
                                  outputBuffer,  &outputBufferLenght);
        
        if(success > -1){
            *data = [NSString stringWithUTF8String: outputBuffer];
            didSucceed = (*data).length;
        }
        else
            goto decompressionError;
    }else
        goto decompressionError;
        
    decompressionError:
    free(outputBuffer);
    
    return didSucceed;
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

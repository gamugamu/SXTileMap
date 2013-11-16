//
//  SXConverser.m
//  SXTileMap
//
//  Created by Abadie, Loïc on 08/11/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "SXConverser.h"
#import "lzfx.h"
#import "SXTypes_private.h"

NSString* const dataGenericMapName = @"data";
NSString* const dataGenericMapNameExtension = @"txt";

void writeToFile(char *filename, const char* input, unsigned lenght);
char* readFile(const char *filename, unsigned* lenght, unsigned* errorCode);

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

+ (BOOL)decompressSXDataAtPath:(NSString*)documentPath data:(NSString* __strong*)data{
    unsigned compressedLenght   = 0;
    unsigned outputBufferLenght = 0;
    char* outputBuffer          = NULL;
    bool didSucceed             = false;
    SXError error               = SXError_None;
    
    NSString* dataPath = [NSString stringWithFormat:@"%@/%@", documentPath, dataGenericMapName];
    NSString* fullPath = [[NSBundle mainBundle] pathForResource: dataPath
                                                         ofType: dataGenericMapNameExtension];
    
    // error invalid Path
    if(!fullPath)
        error = SXError_WrongPath;
    
    char* compressedData = readFile([fullPath UTF8String], &compressedLenght, NULL);
    
    if(!compressedData){
        error = SXError_InvalidFile;
        goto decompressionError;

    }else{
        // first we need to konw the buffer size. According to the doc, it's very
        // fast. It say also to send an output buffer null to get the actual size,
        // wich is not actually what i see. We need to send a valid pointer.
        int success = lzfx_decompress(compressedData, compressedLenght,
                                      &outputBuffer,  // we're faking a pointer an order to get the length.
                                      // It's not actually used into the implementation. If
                                      // we don't, we'll get an error parameter return value.
                                      // Since outputBufferLenght is 0, it's ok.
                                      &outputBufferLenght);
        
        if(success > -1){
            outputBuffer = (char*)malloc(sizeof(char) * outputBufferLenght);
            
            // that should never happen.
            if(!outputBuffer){
                error = SXError_outOfMemory;
                goto decompressionError;
            }
            
            // if everything is ok, we can decompress the data.
            success = lzfx_decompress(compressedData, compressedLenght,
                                      outputBuffer,  &outputBufferLenght);
            
            if(success > -1){
                *data = [NSString stringWithUTF8String: outputBuffer];
                didSucceed = (*data).length;
                
                if(!didSucceed)
                    error = SXError_InvalidFile;
            }
            else{
                error = SXError_InvalidFile;
                goto decompressionError;
            }
        }else
            error = SXError_InvalidFile;
        goto decompressionError;
    }
    
    decompressionError:
    
    free(outputBuffer);
    free(compressedData);
    
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
    char *buffer = NULL;
    int read_size;
    
    FILE *handler = fopen(filename, "r");
    
    if(handler){
        fseek(handler, 0, SEEK_END);
        
        *lenght = ftell(handler);
        rewind(handler);
        
        buffer      = (char*)malloc(sizeof(char) * (*lenght + 1) );
        read_size   = fread(buffer,sizeof(char), *lenght, handler);
        
        if(*lenght != read_size){
            free(buffer);
            buffer = NULL;
            
            if(errorCode)
                *errorCode = 100;
            
            goto readFileFailed;
        }
    }else{
        if(errorCode)
            *errorCode = 100;
        
        readFileFailed:
        *lenght = 0;
    }
    
    return buffer;
}

@end

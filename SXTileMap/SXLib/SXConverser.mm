//
//  SXConverser.m
//  SXTileMap
//
//  Created by Abadie, Loïc on 08/11/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "SXConverser.h"
#import "SXTypes_private.h"
#import "SXErrorFromType.h"
#import "lzfx.h"

NSString* const dataGenericMapName = @"data";
NSString* const dataGenericMapNameExtension = @"txt";

void writeToFile(char *filename, const char* input, unsigned lenght);
char* readFile(const char *filename, unsigned* lenght, unsigned* errorCode);

@implementation SXConverser

+ (BOOL)archivefile:(NSString*)file atPath:(NSString*)dcumentPath{
    unsigned lenght = 200;
#warning TODO and unsafe
    
    char test[]     = "0015001500300030|010flower.png000200020_1_2_3_\0";
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

+ (BOOL)decompressSXDataAtPath: (NSString*)documentPath
                      fileName: (NSString*)fileName
                          data: (NSString* __strong*)data
                         error: (NSError* __autoreleasing*)error{
    unsigned compressedLenght   = 0;
    unsigned outputBufferLenght = 0;
    char* outputBuffer          = NULL;
    bool didSucceed             = false;
    char* compressedData        = NULL;
    SXError errorType           = SXError_None;
    
    NSString* dataPath = [NSString stringWithFormat:@"%@/%@", documentPath, fileName];
    NSString* fullPath = [[NSBundle mainBundle] pathForResource: dataPath
                                                         ofType: nil];

    // error invalid Path
    if(!fullPath){
        errorType = SXError_WrongPath;
    }else{
        
        compressedData = readFile([fullPath UTF8String], &compressedLenght, NULL);
        
        if(!compressedData){
            errorType = SXError_InvalidFile;
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
                    errorType = SXError_outOfMemory;
                    goto decompressionError;
                }
                
                // if everything is ok, we can decompress the data.
                success = lzfx_decompress(compressedData, compressedLenght,
                                          outputBuffer,  &outputBufferLenght);
                
                if(success > -1){
                    *data = [NSString stringWithUTF8String: outputBuffer];
                    didSucceed = (*data).length;
                    
                    if(!didSucceed)
                        errorType = SXError_InvalidFile;
                }
                else
                    errorType = SXError_InvalidFile;
            }else
                errorType = SXError_InvalidFile;
        }
    }
    
    decompressionError:
    
    free(outputBuffer);
    free(compressedData);
    
    if(error && errorType != SXError_None)
        *error = [SXErrorFromType errorFromType: errorType
                               withSuppliedInfo: dataPath];
    
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

+ (void)testArchive{
    char test[]     = "0002000200300030|010flower.png000200020_1_2_3_\n";
    unsigned lenght =  sizeof(test) / sizeof(*test);
    unsigned lenght_2 = 200;

    char* output    = (char*)calloc(lenght_2, sizeof(char));
    
    if(output == NULL)
        printf("failed\n");
    
    int success = lzfx_compress(test, lenght,
                                output, &lenght_2);
    
    printf("\n\n******* %i %u\n", success, lenght_2);

    for (int i = 0; i < lenght_2; i++) {
        printf("%c", output[i]);
    }
    
    char file[] = "/Users/loicabadie/Desktop/test.txt";
    writeToFile(file, output, lenght_2);
    
    char* outputBuffer = NULL;
    unsigned outputBufferLenght = 0;

    success = lzfx_decompress(output, lenght_2,
                            &outputBuffer, &outputBufferLenght);

    outputBuffer = (char*)malloc(sizeof(char) * outputBufferLenght);
    printf("\noutputBufferLenght %i %i \n", success, outputBufferLenght);
    
    success = lzfx_decompress(output, lenght_2,
                              outputBuffer, &outputBufferLenght);
    
    printf("\n\n******* %i %u\n", success, lenght);

    for (int i = 0; i < lenght; i++) {
        printf("%c", outputBuffer[i]);
    }
    
 
    printf("\n\n******* \n");
}

@end

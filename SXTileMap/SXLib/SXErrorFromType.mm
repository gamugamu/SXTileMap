//
//  SXErrorFromType.m
//  SXTileMap
//
//  Created by loïc Abadie on 16/11/2013.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "SXErrorFromType.h"

@implementation SXErrorFromType

+ (NSError*)errorFromType:(SXError)errorType withSuppliedInfo:(NSString*)suppliedInfo{
    NSString* info = nil;
    
    switch (errorType) {
        case SXError_None:
            return nil;
            break;
            
        case SXError_WrongPath:
            info = @"file not found";
            break;
            
        case SXError_InvalidFile:
            info = @"file invalid";
            break;
            
        case SXError_outOfMemory:
            info = @"out of memory";
            break;
            
        default:
            break;
    }
    
    NSMutableString* errorString = [NSMutableString stringWithFormat: @"SXError: %@", info];
    
    if(suppliedInfo)
        [errorString appendFormat: @" \"%@\"", suppliedInfo];
    
    NSError* error = [NSError errorWithDomain: errorString
                                         code: errorType
                                     userInfo: nil];
    
    return error;
}

@end

//
//  SXErrorFromType.h
//  SXTileMap
//
//  Created by loïc Abadie on 16/11/2013.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXTypes_private.h"

@interface SXErrorFromType : NSObject

+ (NSError*)errorFromType: (SXError)errorType
         withSuppliedInfo: (NSString*)suppliedInfo;

@end

//
//  SXConverser.h
//  SXTileMap
//
//  Created by Abadie, Loïc on 08/11/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
    Archive / Unarchive SXFileData
 */
@interface SXConverser : NSObject

+ (BOOL)archivefile:(NSString*)file atPath:(NSString*)dcumentPath;
+ (BOOL)unarchivefile:(NSString*)dcumentPath;

@end
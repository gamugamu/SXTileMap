//
//  SXFileManager.h
//  SXTileMap
//
//  Created by Abadie, Loïc on 13/11/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXFileManager : NSObject

- (id)initFileManagerWithRelativeFolderRessource:(NSString*)relativeRessource;

- (NSString*)pathForRessource:(NSString*)ressourceName;
@end

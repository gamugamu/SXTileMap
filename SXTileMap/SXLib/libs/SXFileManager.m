//
//  SXFileManager.m
//  SXTileMap
//
//  Created by Abadie, Loïc on 13/11/13.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#import "SXFileManager.h"

@interface SXFileManager()
@property(nonatomic, strong)NSString* relativePath;
@end

@implementation SXFileManager
@synthesize relativePath = _relativePath;

#pragma mark -------------------------- public ---------------------------------
#pragma mark -------------------------------------------------------------------

- (id)initFileManagerWithRelativeFolderRessource:(NSString*)relativeRessource{
    if(self = [super init]){
        [self setUpRelativePath: relativeRessource];
    }
    return self;
}

#pragma mark -------------------------- private --------------------------------
#pragma mark -------------------------------------------------------------------

- (void)setUpRelativePath:(NSString*)relativeRessource{
    NSString* path = [NSString stringWithFormat: @"%@/rgb_2.png", relativeRessource];
    NSLog(@"test 2 %@",  [[NSBundle mainBundle] pathForResource: path ofType: nil]);
}

@end

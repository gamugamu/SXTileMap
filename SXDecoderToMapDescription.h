//
//  SXDecoderToMapAtlasDescription.h
//  SXTileMap
//
//  Created by loïc Abadie on 10/11/2013.
//  Copyright (c) 2013 Abadie Loic. All rights reserved.
//

#ifndef SXTileMap_SXDecoderToMapAtlasDescription_h
#define SXTileMap_SXDecoderToMapAtlasDescription_h
class _SXDecodedMapData;
class _SXMapDescription;

// Convert opaque type _SXDecodedMapData to opaque type _SXMapDescription

/**
    Convert opaque type _SXDecodedMapData to opaque type _SXMapDescription
    @param
*/
void sxInitAndConvertDecodedToMapDescription(const _SXDecodedMapData*, _SXMapDescription*);

/**
    free **
 */
void sxReleaseMapDescription(_SXMapDescription*);

#endif

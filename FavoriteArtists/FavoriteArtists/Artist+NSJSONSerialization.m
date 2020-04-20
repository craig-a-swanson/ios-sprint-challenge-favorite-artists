//
//  Artist+NSJSONSerialization.m
//  FavoriteArtists
//
//  Created by Craig Swanson on 4/19/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import "Artist+NSJSONSerialization.h"

@implementation Artist (NSJSONSerialization)

// This method does double duty as decoding the JSON from the server as well as converting the locally-saved dictionary.
// I originally started at the top of the array to decode the JSON, but that complicated things for reading the dictionary from the local device's documents directory. The solution was to step into the array when we are in the data task, and then use that dictionary for this method.
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
        NSString *artist = [dictionary objectForKey:@"strArtist"];
        if (![artist isKindOfClass:[NSString class]]) return nil;
        
        NSString *biography = [dictionary objectForKey:@"strBiographyEN"];
        if (![biography isKindOfClass:[NSString class]]) return nil;
        
        NSNumber *yearFormedNumber = [dictionary objectForKey:@"intFormedYear"];
        if ([yearFormedNumber isKindOfClass:[NSNull class]])
            yearFormedNumber = nil;
        
        uint formed = yearFormedNumber.unsignedIntValue;
        
        return [self initWithName:artist biography:biography formed:formed];
}

// Pass in an artist and save it as a dictionary to store in the local documents directory
- (NSDictionary *)toDictionary:(Artist *)artist {
    NSString *formed = [NSString stringWithFormat:@"%d", artist.intFormedYear];
    
    NSDictionary *artistDictionary = @{
        @"strArtist":artist.strArtist,
        @"strBiographyEN":artist.strBiographyEN,
        @"intFormedYear":formed
    };
    
    return artistDictionary;
}

@end

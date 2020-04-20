//
//  Artist+NSJSONSerialization.m
//  FavoriteArtists
//
//  Created by Craig Swanson on 4/19/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import "Artist+NSJSONSerialization.h"

@implementation Artist (NSJSONSerialization)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSArray *artists = [dictionary objectForKey:@"artists"];
    if (![artists isKindOfClass:[NSArray class]]) return nil;
    
    NSDictionary *artistResult = [artists objectAtIndex:0];
    NSString *artist = [artistResult objectForKey:@"strArtist"];
    if (![artist isKindOfClass:[NSString class]]) return nil;
    
    NSString *biography = [artistResult objectForKey:@"strBiographyEN"];
    if (![biography isKindOfClass:[NSString class]]) return nil;
    
    NSNumber *yearFormedNumber = [artistResult objectForKey:@"intFormedYear"];
    if (![yearFormedNumber isKindOfClass:[NSNumber class]]) return nil;
    
    uint formed = yearFormedNumber.unsignedIntValue;
    
    return [self initWithName:artist biography:biography formed:formed];
}

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

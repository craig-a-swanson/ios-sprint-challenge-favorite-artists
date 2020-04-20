//
//  Artist.m
//  FavoriteArtists
//
//  Created by Craig Swanson on 4/19/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import "Artist.h"

@implementation Artist

- (instancetype)initWithName:(NSString *)strArtist biography:(NSString *)strBiographyEN formed:(uint)intFormedYear {
    if (self = [super init]) {
        _strArtist = strArtist;
        _strBiographyEN = strBiographyEN;
        _intFormedYear = intFormedYear;
    }
    return self;
}

@end

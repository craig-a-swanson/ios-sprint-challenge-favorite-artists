//
//  Artist.h
//  FavoriteArtists
//
//  Created by Craig Swanson on 4/19/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Artist : NSObject

@property (nonatomic, readonly, copy) NSString *strArtist;
@property (nonatomic, readonly, copy) NSString *strBiographyEN;
@property (nonatomic, readonly) uint intFormedYear;

- (instancetype)initWithName:(NSString *)strArtist
                   biography:(NSString *)strBiographyEN
                      formed:(uint)intFormedYear;

@end

NS_ASSUME_NONNULL_END

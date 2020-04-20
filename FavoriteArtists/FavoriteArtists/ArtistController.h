//
//  ArtistController.h
//  FavoriteArtists
//
//  Created by Craig Swanson on 4/19/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Artist;

typedef void(^ArtistControllerCompletionHandler)(Artist *_Nullable artist, NSError*_Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface ArtistController : NSObject

@property (strong, nonatomic) NSArray<Artist *> *artists;

- (void)saveArtistWithName:(NSString *)artistName
                     founded:(uint)artistFounded
                   biography:(NSString *)artistBio;

- (void)fetchArtist:(NSString *)artistName completionHandler:(ArtistControllerCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END

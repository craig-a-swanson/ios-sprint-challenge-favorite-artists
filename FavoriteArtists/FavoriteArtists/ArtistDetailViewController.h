//
//  ArtistDetailViewController.h
//  FavoriteArtists
//
//  Created by Craig Swanson on 4/19/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Artist;

NS_ASSUME_NONNULL_BEGIN

@interface ArtistDetailViewController : UIViewController

@property (nonatomic, strong) Artist *artist;

@end

NS_ASSUME_NONNULL_END

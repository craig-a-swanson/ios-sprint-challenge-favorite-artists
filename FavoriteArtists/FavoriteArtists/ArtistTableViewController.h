//
//  ArtistTableViewController.h
//  FavoriteArtists
//
//  Created by Craig Swanson on 4/19/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "ArtistViewController.h"

@class Artist;
@class ArtistViewController;

NS_ASSUME_NONNULL_BEGIN

@interface ArtistTableViewController : UITableViewController <ArtistTableViewControllerDelegate>

@property (nonatomic, strong) NSArray<Artist *> *artists;

@end

NS_ASSUME_NONNULL_END

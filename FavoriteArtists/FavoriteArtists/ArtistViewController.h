//
//  ArtistViewController.h
//  FavoriteArtists
//
//  Created by Craig Swanson on 4/19/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ArtistController;

NS_ASSUME_NONNULL_BEGIN

@interface ArtistViewController : UIViewController <UISearchBarDelegate>

@property (strong, nonatomic) ArtistController *artistController;

@end

NS_ASSUME_NONNULL_END

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
@class ArtistTableViewController;
@class Artist;

// I used a delegate protocol to pass data from the search VC to the table VC.
@protocol ArtistTableViewControllerDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface ArtistViewController : UIViewController <UISearchBarDelegate>

@property (nonatomic, strong) id<ArtistTableViewControllerDelegate> delegate;
@property (strong, nonatomic) ArtistController *artistController;

@end

NS_ASSUME_NONNULL_END

@protocol ArtistTableViewControllerDelegate <NSObject>
- (void)getArtistsArray:(NSArray<Artist *> *_Nullable)artists;
@end

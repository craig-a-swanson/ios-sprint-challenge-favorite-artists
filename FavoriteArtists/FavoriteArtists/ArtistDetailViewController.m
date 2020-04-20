//
//  ArtistDetailViewController.m
//  FavoriteArtists
//
//  Created by Craig Swanson on 4/19/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import "ArtistDetailViewController.h"
#import "Artist.h"

@interface ArtistDetailViewController ()

@property (strong, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *artistFormedLabel;
@property (strong, nonatomic) IBOutlet UITextView *artistBioTextView;

@end

@implementation ArtistDetailViewController

@synthesize artist = _artist;

-(void)setArtist:(Artist *)artist {
    _artist = artist;
    [self updateViews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateViews];
}

- (void)updateViews {
    self.artistNameLabel.text = _artist.strArtist;
    self.artistFormedLabel.text = [NSString stringWithFormat:@"Formed in %d", _artist.intFormedYear];
    self.artistBioTextView.text = _artist.strBiographyEN;
}

@end

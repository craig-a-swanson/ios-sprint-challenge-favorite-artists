//
//  ArtistController.m
//  FavoriteArtists
//
//  Created by Craig Swanson on 4/19/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import "ArtistController.h"
#import "Artist.h"
#import "Artist+NSJSONSerialization.h"

static NSString *const ArtistFetcherBaseURLString = @"https://theaudiodb.com/api/v1/json/1/search.php";

@interface ArtistController ()

@property (strong, nonatomic) NSMutableArray<Artist *> *internalArtists;
@property (nonatomic) NSURL *artistURL;

@end

@implementation ArtistController

- (instancetype)init {
    if (self = [super init]) {
        _internalArtists = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray<Artist *> *)artists {
    return [self.internalArtists copy];
}

- (void)saveArtistWithName:(NSString *)artistName
                     founded:(uint)artistFounded
                   biography:(NSString *)artistBio {
    Artist *artist = [[Artist alloc] initWithName:artistName
                                        biography:artistBio
                                           formed:artistFounded];
    
    [self.internalArtists addObject:artist];
    
    NSURL *documentURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    _artistURL = [documentURL URLByAppendingPathComponent:@"Artists.plist"];
    NSLog(@"Document URL: %@", _artistURL);
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (Artist *currentArtist in _internalArtists) {
        [tempArray addObject:[[Artist alloc] toDictionary:currentArtist]];
    }
    BOOL status = [tempArray writeToURL:_artistURL atomically:YES];
    NSLog(@"Write status %d", status);
}


- (void)fetchArtist:(NSString *)artistName completionHandler:(ArtistControllerCompletionHandler)completionHandler {
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:ArtistFetcherBaseURLString];
    
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"s" value:artistName]
    ];
    
    NSURL *url = urlComponents.URL;
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error retrieving artist: %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if(!dictionary) {
            NSLog(@"Error decoding JSON: %@", jsonError);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, jsonError);
            });
            return;
        }
        
        NSArray *jsonArtistsArray = dictionary[@"artists"];
        
        if (jsonArtistsArray.count > 0) {
            
            // Access the first element of the array for the artist data
            NSDictionary *artistDictionary = jsonArtistsArray[0];
            Artist *artistResult = [[Artist alloc] initWithDictionary:artistDictionary];
            if (!artistResult) {
                NSError *error = [NSError errorWithDomain:@"ArtistControllerDomain" code:-1 userInfo:nil];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    completionHandler(nil, error);
                });
                return;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(artistResult, nil);
            });
        }
    }] resume];
}

-(void)loadArtistsFromDirectory {
    NSURL *documentURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    _artistURL = [documentURL URLByAppendingPathComponent:@"Artists.plist"];
    
    NSArray *artistsArray = [[NSArray alloc] initWithContentsOfURL:_artistURL];
    for (NSDictionary *artistDict in artistsArray) {
        Artist *currentArtist = [[Artist alloc] initWithDictionary:artistDict];
        [_internalArtists addObject:currentArtist];
    }
}

@end

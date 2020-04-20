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

@property (nonatomic) NSMutableArray<Artist *> *internalArtists;

@end

@implementation ArtistController


// Snippet for writing to the documents directory
//NSDictionary *dict = @{@"key2":@"Eezy",@"key1": @"Tutorials", @"key3":@"Website"};
//NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
//NSString *documentsDirectory = [pathArray objectAtIndex:0];
//NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"myDict.plist"];
//NSURL *url = [NSURL fileURLWithPath:filePath];
//BOOL status = [dict writeToURL:url atomically:YES];
//NSLog(@"Write Status %d",status);

// Snippet for reading from the documents directory
//NSURL *url = [NSURL URLWithString:@"http://ios.eezytutorials.com/sample-files/sample-dictionary-plist.plist"];
//NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfURL:url];
//NSLog(@"%@",url);

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
        
        Artist *artistResult = [[Artist alloc] initWithDictionary:dictionary];
        if (!artistResult) {
            NSError *error = [NSError errorWithDomain:@"ArtistControllerDomain" code:-1 userInfo:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });
            return;
        }
        
//        [self.internalArtists addObject:artistResult];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(artistResult, nil);
        });
        
    }] resume];
}

@end

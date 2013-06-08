//
//  TTTMatch.m
//  TableTennisTime
//
//  Created by Sheel Choksi on 5/20/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import "TTTMatch.h"

@implementation TTTMatch
{
    NSUserDefaults* settings;
    TTTRestClient* client;
}

- (TTTMatch*)initWithSettings:(NSUserDefaults*)userSettings andRestClient:(TTTRestClient*)restClient
{
    settings = userSettings;
    client = restClient;
    [self refreshFromSettings];
    return self;
}

- (void)createMatchFromOptions:(NSDictionary*)options
{
    [options enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL* stop){
        [settings setObject:obj forKey:key];
    }];
    [self refreshFromSettings];
    [client post:@"/matches" options:options callback:^(id resp){}];
}

- (void)refreshFromSettings
{
    [@[@"names", @"matchType", @"numPlayers"] enumerateObjectsUsingBlock:^(id key, NSUInteger index, BOOL* stop){
        [self setValue:[settings objectForKey:key] forKey:key];
    }];
}

@end

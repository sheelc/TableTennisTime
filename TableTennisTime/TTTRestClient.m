//
//  TTTRestClient.m
//  TableTennisMatchup
//
//  Created by Sheel Choksi on 5/18/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import "TTTRestClient.h"
#import "TTTResponse.h"

@implementation TTTRestClient
{
    NSUserDefaults* userSettings;
}

- (TTTRestClient*)initWithSettings: (NSUserDefaults*) settings
{
    userSettings = settings;
    self.target = [userSettings objectForKey:@"target"];
    return self;
}

- (void)updateTarget:(NSString*)target
{
    self.target = target;
    [userSettings setObject:self.target forKey:@"target"];
}

- (void)targetValid:(void ( ^ )(BOOL))callback
{
    [self get:@"/info" callback: ^(TTTResponse* response) {
        if([response success]){
            callback(YES);
        } else {
            callback(NO);
        }
    }];
}

- (void)get:(NSString*)path callback:(void ( ^ )(id)) callback
{
    NSString* url = [self.target stringByAppendingString:path];
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url]
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];

    [NSURLConnection
     sendAsynchronousRequest:theRequest
     queue: [NSOperationQueue mainQueue]
     completionHandler:^(NSURLResponse* response, NSData* data, NSError* error){
        callback([TTTResponse initFromData:data error:error]);
     }
    ];
}

@end

//
//  TTMRestClient.m
//  TableTennisMatchup
//
//  Created by Sheel Choksi on 5/18/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import "TTMRestClient.h"
#import "TTMResponse.h"

@implementation TTMRestClient

- (TTMRestClient*)init
{
    NSUserDefaults *userSettings = [[NSUserDefaults alloc] init];
    self.target = [userSettings objectForKey:@"target"];
    return self;
}

- (void)updateTarget:(NSString*)target
{
    [self updateTarget:target callback:^(BOOL success){}];
}

- (void)updateTarget:(NSString*)target callback:(void ( ^ )(BOOL)) callback
{
    self.target = target;
    [self targetValid:^(BOOL valid) {
        if (valid) {
            [self persistTarget];
            callback(YES);
        } else {
            callback(NO);
        }
    }];
}

- (void)targetValid:(void ( ^ )(BOOL))callback
{
    [self get:@"/info" callback: ^(TTMResponse* response) {
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
        callback([TTMResponse initFromData:data error:error]);
     }
    ];
}

- (void)persistTarget
{
    NSUserDefaults *userSettings = [[NSUserDefaults alloc] init];
    [userSettings setObject:self.target forKey:@"target"];
}

@end

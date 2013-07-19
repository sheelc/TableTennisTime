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

- (id)initWithSettings: (NSUserDefaults*) settings
{
    self = [super init];
    if (self) {
        userSettings = settings;
        self.target = [userSettings objectForKey:@"target"];
    }
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
    [self makeRequest:path withCallback:callback];
}

- (void)post:(NSString*)path options:(NSDictionary*)body callback:(void ( ^ )(id)) callback
{
    [self
     makeRequest:path
     requestCustomization:^(NSMutableURLRequest* theRequest) {
        NSError* jsonParseErrors;
        
        [theRequest setHTTPMethod:@"POST"];
        [theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
        [theRequest setHTTPBody:[NSJSONSerialization dataWithJSONObject:body options:0 error: &jsonParseErrors]];
     }
     withCallback:callback];
    
}

- (void) makeRequest: (NSString*)path withCallback:(void (^)(TTTResponse*)) callback
{
    [self makeRequest:path requestCustomization:^(NSMutableURLRequest* theRequest){} withCallback:callback];
}

- (void) makeRequest: (NSString*)path requestCustomization:(void ( ^ )(NSMutableURLRequest*)) requestCustomization withCallback:(void (^)(TTTResponse*)) callback
{
    NSString* url = [self.target stringByAppendingString:path];
    NSMutableURLRequest* theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                            cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                        timeoutInterval:60.0];
    requestCustomization(theRequest);
    
    [NSURLConnection
     sendAsynchronousRequest:theRequest
     queue: [NSOperationQueue mainQueue]
     completionHandler:^(NSURLResponse* response, NSData* data, NSError* error){
         callback([[TTTResponse alloc] initFromResponse:response data:data error:error]);
     }
    ];
}

@end
